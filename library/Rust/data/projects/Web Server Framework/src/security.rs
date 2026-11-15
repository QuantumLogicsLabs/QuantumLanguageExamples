//! Security: HTML escaping, path checks, rate limiting, Basic authentication and the headers
//! that make browsers more careful.

use std::collections::HashMap;
use std::sync::Mutex;
use std::time::{Duration, Instant};

use crate::handlers::BoxFuture;
use crate::http::{Request, Response, StatusCode};
use crate::middleware::{Middleware, Next};

/// Escapes the characters HTML gives a meaning to, so text can go into a page safely.
pub fn escape_html(text: &str) -> String {
    let mut out = String::with_capacity(text.len());
    for c in text.chars() {
        match c {
            '&' => out.push_str("&amp;"),
            '<' => out.push_str("&lt;"),
            '>' => out.push_str("&gt;"),
            '"' => out.push_str("&quot;"),
            '\'' => out.push_str("&#39;"),
            _ => out.push(c),
        }
    }
    out
}

/// Whether a requested file path stays inside the folder it is served from: no `..` part, no
/// drive or root, no NUL.
pub fn is_safe_path(path: &str) -> bool {
    !path.contains('\0')
        && !path.starts_with('/')
        && !path.starts_with('\\')
        && !path.contains(':')
        && !path.split(|c| c == '/' || c == '\\').any(|part| part == "..")
}

/// Standard base64, with `=` padding.
pub fn base64_encode(data: &[u8]) -> String {
    const TABLE: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    let mut out = String::with_capacity((data.len() + 2) / 3 * 4);
    for chunk in data.chunks(3) {
        let b = [chunk[0], *chunk.get(1).unwrap_or(&0), *chunk.get(2).unwrap_or(&0)];
        let n = (b[0] as u32) << 16 | (b[1] as u32) << 8 | b[2] as u32;
        for k in 0..4 {
            if k <= chunk.len() {
                out.push(TABLE[(n >> (18 - 6 * k) & 63) as usize] as char);
            } else {
                out.push('=');
            }
        }
    }
    out
}

/// Lets each client (by IP address) make `limit` requests per `window`; the ones over it get
/// 429 Too Many Requests.
pub struct RateLimiter {
    limit: u32,
    window: Duration,
    clients: Mutex<HashMap<String, (Instant, u32)>>,
}

impl RateLimiter {
    pub fn new(limit: u32, window: Duration) -> Self {
        RateLimiter { limit, window, clients: Mutex::new(HashMap::new()) }
    }

    /// Counts a request from `client`; false when it is over the limit.
    pub fn check(&self, client: &str) -> bool {
        let now = Instant::now();
        let mut clients = self.clients.lock().unwrap();
        let entry = clients.entry(client.to_string()).or_insert((now, 0));
        if now.duration_since(entry.0) >= self.window {
            *entry = (now, 0);
        }
        entry.1 += 1;
        entry.1 <= self.limit
    }
}

impl Middleware for RateLimiter {
    fn handle<'a>(&'a self, req: Request, next: Next<'a>) -> BoxFuture<'a, Response> {
        // a client's port changes with each connection: it is known by its address
        let addr = req.remote_addr.clone().unwrap_or_else(|| "unknown".to_string());
        let client = match addr.rsplit_once(':') {
            Some((ip, _port)) => ip.to_string(),
            None => addr,
        };
        if self.check(&client) {
            next.run(req)
        } else {
            Box::pin(async {
                Response::error(StatusCode::TOO_MANY_REQUESTS, "Too many requests: slow down.")
                    .with_header("Retry-After", "1")
            })
        }
    }
}

/// Asks for a user name and password (HTTP Basic authentication) before the request goes on.
pub struct BasicAuth {
    realm: String,
    credentials: String,
}

impl BasicAuth {
    pub fn new(realm: &str, user: &str, password: &str) -> Self {
        BasicAuth {
            realm: realm.to_string(),
            credentials: base64_encode(format!("{}:{}", user, password).as_bytes()),
        }
    }
}

impl Middleware for BasicAuth {
    fn handle<'a>(&'a self, req: Request, next: Next<'a>) -> BoxFuture<'a, Response> {
        let authorized = req
            .header("authorization")
            .and_then(|value| value.strip_prefix("Basic "))
            .map(|given| given.trim() == self.credentials)
            .unwrap_or(false);
        if authorized {
            next.run(req)
        } else {
            let challenge = format!("Basic realm=\"{}\"", self.realm);
            Box::pin(async move {
                Response::error(StatusCode::UNAUTHORIZED, "Authentication required.")
                    .with_header("WWW-Authenticate", challenge)
            })
        }
    }
}

/// Adds the headers that keep browsers from guessing content types, framing the pages or
/// sending the address of the page in the Referer header.
pub struct SecurityHeaders;

impl Middleware for SecurityHeaders {
    fn handle<'a>(&'a self, req: Request, next: Next<'a>) -> BoxFuture<'a, Response> {
        Box::pin(async move {
            next.run(req)
                .await
                .with_header("X-Content-Type-Options", "nosniff")
                .with_header("X-Frame-Options", "DENY")
                .with_header("Referrer-Policy", "no-referrer")
        })
    }
}
