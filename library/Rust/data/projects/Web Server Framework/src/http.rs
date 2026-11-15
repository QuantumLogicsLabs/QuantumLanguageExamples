//! HTTP/1.1 messages: the request a client sends and the response it gets back.

use std::collections::HashMap;
use std::fmt;
use std::str::FromStr;

use crate::error::{Error, Result};
use crate::utils::{parse_query, percent_decode};

/// The request methods the framework routes on.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum Method {
    Get,
    Post,
    Put,
    Delete,
    Patch,
    Head,
    Options,
}

impl Method {
    pub fn as_str(&self) -> &'static str {
        match self {
            Method::Get => "GET",
            Method::Post => "POST",
            Method::Put => "PUT",
            Method::Delete => "DELETE",
            Method::Patch => "PATCH",
            Method::Head => "HEAD",
            Method::Options => "OPTIONS",
        }
    }
}

impl fmt::Display for Method {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(self.as_str())
    }
}

impl FromStr for Method {
    type Err = Error;

    fn from_str(s: &str) -> Result<Self> {
        match s {
            "GET" => Ok(Method::Get),
            "POST" => Ok(Method::Post),
            "PUT" => Ok(Method::Put),
            "DELETE" => Ok(Method::Delete),
            "PATCH" => Ok(Method::Patch),
            "HEAD" => Ok(Method::Head),
            "OPTIONS" => Ok(Method::Options),
            other => Err(Error::BadRequest(format!("unknown method `{}`", other))),
        }
    }
}

/// An HTTP status code.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct StatusCode(pub u16);

impl StatusCode {
    pub const OK: StatusCode = StatusCode(200);
    pub const CREATED: StatusCode = StatusCode(201);
    pub const NO_CONTENT: StatusCode = StatusCode(204);
    pub const MOVED_PERMANENTLY: StatusCode = StatusCode(301);
    pub const FOUND: StatusCode = StatusCode(302);
    pub const NOT_MODIFIED: StatusCode = StatusCode(304);
    pub const BAD_REQUEST: StatusCode = StatusCode(400);
    pub const UNAUTHORIZED: StatusCode = StatusCode(401);
    pub const FORBIDDEN: StatusCode = StatusCode(403);
    pub const NOT_FOUND: StatusCode = StatusCode(404);
    pub const METHOD_NOT_ALLOWED: StatusCode = StatusCode(405);
    pub const REQUEST_TIMEOUT: StatusCode = StatusCode(408);
    pub const PAYLOAD_TOO_LARGE: StatusCode = StatusCode(413);
    pub const TOO_MANY_REQUESTS: StatusCode = StatusCode(429);
    pub const INTERNAL_SERVER_ERROR: StatusCode = StatusCode(500);
    pub const SERVICE_UNAVAILABLE: StatusCode = StatusCode(503);

    pub fn as_u16(&self) -> u16 {
        self.0
    }

    /// The reason phrase that goes with the code: 404 → "Not Found".
    pub fn reason(&self) -> &'static str {
        match self.0 {
            200 => "OK",
            201 => "Created",
            204 => "No Content",
            301 => "Moved Permanently",
            302 => "Found",
            304 => "Not Modified",
            400 => "Bad Request",
            401 => "Unauthorized",
            403 => "Forbidden",
            404 => "Not Found",
            405 => "Method Not Allowed",
            408 => "Request Timeout",
            413 => "Payload Too Large",
            429 => "Too Many Requests",
            500 => "Internal Server Error",
            503 => "Service Unavailable",
            _ => "Unknown",
        }
    }

    pub fn is_success(&self) -> bool {
        (200..300).contains(&self.0)
    }

    pub fn is_client_error(&self) -> bool {
        (400..500).contains(&self.0)
    }

    pub fn is_server_error(&self) -> bool {
        self.0 >= 500
    }
}

impl fmt::Display for StatusCode {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{} {}", self.0, self.reason())
    }
}

/// Where the head of a request ends (just after its blank line), once it has all arrived.
pub fn head_end(raw: &[u8]) -> Option<usize> {
    raw.windows(4).position(|w| w == b"\r\n\r\n").map(|at| at + 4)
}

/// A request: its method and path, the query string, headers (by lower-case name), the route's
/// parameters and the body.
#[derive(Debug, Clone)]
pub struct Request {
    pub method: Method,
    pub path: String,
    pub version: String,
    pub query: HashMap<String, String>,
    pub headers: HashMap<String, String>,
    pub params: HashMap<String, String>,
    pub body: Vec<u8>,
    pub remote_addr: Option<String>,
}

impl Request {
    /// A request for `target` (a path with an optional query string), without headers or body.
    pub fn new(method: Method, target: &str) -> Self {
        let (path, query) = match target.split_once('?') {
            Some((path, query)) => (path, parse_query(query)),
            None => (target, HashMap::new()),
        };
        Request {
            method,
            path: percent_decode(path),
            version: "HTTP/1.1".to_string(),
            query,
            headers: HashMap::new(),
            params: HashMap::new(),
            body: Vec::new(),
            remote_addr: None,
        }
    }

    /// Parses a whole request as it came off the wire: the head, then the body.
    pub fn parse(raw: &[u8]) -> Result<Self> {
        let end = head_end(raw).ok_or_else(|| Error::BadRequest("the request head is not complete".to_string()))?;
        let head = std::str::from_utf8(&raw[..end])
            .map_err(|_| Error::BadRequest("the request head is not UTF-8".to_string()))?;
        let mut lines = head.split("\r\n");
        let request_line = lines.next().unwrap_or("");
        let mut parts = request_line.split_whitespace();
        let (method, target, version) = match (parts.next(), parts.next(), parts.next()) {
            (Some(method), Some(target), Some(version)) => (method, target, version),
            _ => return Err(Error::BadRequest(format!("malformed request line `{}`", request_line))),
        };
        let mut request = Request::new(Method::from_str(method)?, target);
        request.version = version.to_string();
        for line in lines.filter(|line| !line.is_empty()) {
            let (name, value) = line
                .split_once(':')
                .ok_or_else(|| Error::BadRequest(format!("malformed header `{}`", line)))?;
            request.headers.insert(name.trim().to_ascii_lowercase(), value.trim().to_string());
        }
        request.body = raw[end..].to_vec();
        Ok(request)
    }

    /// A header's value; the name is not case sensitive.
    pub fn header(&self, name: &str) -> Option<&str> {
        self.headers.get(&name.to_ascii_lowercase()).map(|value| value.as_str())
    }

    /// A query string parameter: `?page=2` → `query("page")` is `Some("2")`.
    pub fn query(&self, name: &str) -> Option<&str> {
        self.query.get(name).map(|value| value.as_str())
    }

    /// A parameter of the route: `/users/:id` matched by `/users/7` → `param("id")` is `Some("7")`.
    pub fn param(&self, name: &str) -> Option<&str> {
        self.params.get(name).map(|value| value.as_str())
    }

    /// How long the body is, by its Content-Length header.
    pub fn content_length(&self) -> usize {
        self.header("content-length").and_then(|value| value.parse().ok()).unwrap_or(0)
    }

    /// The body as text (invalid UTF-8 is replaced).
    pub fn body_text(&self) -> String {
        String::from_utf8_lossy(&self.body).into_owned()
    }

    /// The request with a header added (for building requests in tests).
    pub fn with_header(mut self, name: &str, value: &str) -> Self {
        self.headers.insert(name.to_ascii_lowercase(), value.to_string());
        self
    }

    /// The request with a body.
    pub fn with_body(mut self, body: impl Into<Vec<u8>>) -> Self {
        self.body = body.into();
        self
    }
}

/// A response: a status, headers in the order they were set, and the body.
#[derive(Debug, Clone)]
pub struct Response {
    pub status: StatusCode,
    pub headers: Vec<(String, String)>,
    pub body: Vec<u8>,
}

impl Response {
    pub fn new(status: StatusCode) -> Self {
        Response { status, headers: Vec::new(), body: Vec::new() }
    }

    /// 200 with an HTML page.
    pub fn html(body: impl Into<String>) -> Self {
        Response::bytes("text/html; charset=utf-8", body.into().into_bytes())
    }

    /// 200 with plain text.
    pub fn text(body: impl Into<String>) -> Self {
        Response::bytes("text/plain; charset=utf-8", body.into().into_bytes())
    }

    /// 200 with JSON (the text is sent as it is).
    pub fn json(body: impl Into<String>) -> Self {
        Response::bytes("application/json", body.into().into_bytes())
    }

    /// 200 with any content.
    pub fn bytes(content_type: &str, body: Vec<u8>) -> Self {
        let mut response = Response::new(StatusCode::OK);
        response.set_header("Content-Type", content_type);
        response.body = body;
        response
    }

    /// 302: the client goes to `location`.
    pub fn redirect(location: &str) -> Self {
        Response::new(StatusCode::FOUND).with_header("Location", location)
    }

    /// An error page: the status and a message, as plain text.
    pub fn error(status: StatusCode, message: &str) -> Self {
        Response::text(format!("{}\n{}\n", status, message)).with_status(status)
    }

    /// 404 Not Found.
    pub fn not_found() -> Self {
        Response::error(StatusCode::NOT_FOUND, "The page you asked for does not exist.")
    }

    pub fn with_status(mut self, status: StatusCode) -> Self {
        self.status = status;
        self
    }

    /// The response with a header set (replacing one of the same name).
    pub fn with_header(mut self, name: impl Into<String>, value: impl Into<String>) -> Self {
        self.set_header(name, value);
        self
    }

    pub fn set_header(&mut self, name: impl Into<String>, value: impl Into<String>) {
        let name = name.into();
        let value = value.into();
        match self.headers.iter_mut().find(|(n, _)| n.eq_ignore_ascii_case(&name)) {
            Some(header) => header.1 = value,
            None => self.headers.push((name, value)),
        }
    }

    /// A header's value; the name is not case sensitive.
    pub fn header(&self, name: &str) -> Option<&str> {
        self.headers.iter().find(|(n, _)| n.eq_ignore_ascii_case(name)).map(|(_, value)| value.as_str())
    }

    /// The body as text (invalid UTF-8 is replaced).
    pub fn body_text(&self) -> String {
        String::from_utf8_lossy(&self.body).into_owned()
    }

    /// The response as it goes on the wire.
    pub fn to_bytes(&self) -> Vec<u8> {
        let mut head = format!("HTTP/1.1 {} {}\r\n", self.status.0, self.status.reason());
        if self.header("content-length").is_none() {
            head.push_str(&format!("Content-Length: {}\r\n", self.body.len()));
        }
        for (name, value) in &self.headers {
            head.push_str(&format!("{}: {}\r\n", name, value));
        }
        head.push_str("\r\n");
        let mut out = head.into_bytes();
        out.extend_from_slice(&self.body);
        out
    }
}
