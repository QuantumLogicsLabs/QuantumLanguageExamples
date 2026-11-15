//! Handlers: what answers a request. A handler is any `async` function or closure that takes a
//! `Request` and gives a `Response`; the framework keeps each one as a `Handler`.

use std::future::Future;
use std::path::PathBuf;
use std::pin::Pin;
use std::sync::Arc;

use crate::http::{Request, Response, StatusCode};
use crate::security::is_safe_path;
use crate::utils::mime_type;

/// A boxed future that can move between threads.
pub type BoxFuture<'a, T> = Pin<Box<dyn Future<Output = T> + Send + 'a>>;

/// A handler as the router keeps it.
pub type Handler = Arc<dyn Fn(Request) -> BoxFuture<'static, Response> + Send + Sync>;

/// Turns an async function or closure into a `Handler`.
pub fn handler<F, Fut>(f: F) -> Handler
where
    F: Fn(Request) -> Fut + Send + Sync + 'static,
    Fut: Future<Output = Response> + Send + 'static,
{
    Arc::new(move |req: Request| -> BoxFuture<'static, Response> { Box::pin(f(req)) })
}

/// `GET /health`: whether the server is up, as JSON.
pub async fn health_check(_req: Request) -> Response {
    Response::json(format!("{{\"status\":\"ok\",\"version\":\"{}\"}}", crate::VERSION))
}

/// Answers with what the request was: method, path, query, headers and body. Handy when
/// debugging a client.
pub async fn echo(req: Request) -> Response {
    let mut lines = vec![format!("{} {}", req.method, req.path)];
    let mut query: Vec<_> = req.query.iter().collect();
    query.sort();
    for (name, value) in query {
        lines.push(format!("query {} = {}", name, value));
    }
    let mut headers: Vec<_> = req.headers.iter().collect();
    headers.sort();
    for (name, value) in headers {
        lines.push(format!("header {}: {}", name, value));
    }
    if !req.body.is_empty() {
        lines.push(format!("body {}", req.body_text()));
    }
    Response::text(lines.join("\n"))
}

/// What the server answers when no route matches.
pub async fn not_found(req: Request) -> Response {
    Response::error(StatusCode::NOT_FOUND, &format!("No route for {} {}", req.method, req.path))
}

/// Serves the files under `root`. Mount it on a wildcard route: with `/static/*`, a request for
/// `/static/css/app.css` gets `root/css/app.css`; `/static/` gets `root/index.html`.
pub fn static_files(root: impl Into<PathBuf>) -> Handler {
    let root: PathBuf = root.into();
    handler(move |req: Request| {
        let wanted = req.param("*").filter(|rest| !rest.is_empty()).unwrap_or("index.html").to_string();
        let path = root.join(&wanted);
        async move {
            if !is_safe_path(&wanted) {
                return Response::error(StatusCode::FORBIDDEN, "That path leaves the served folder.");
            }
            match tokio::fs::read(&path).await {
                Ok(data) => Response::bytes(mime_type(&wanted), data),
                Err(_) => Response::not_found(),
            }
        }
    })
}
