//! The middleware pipeline (chain of responsibility): each middleware gets the request and the
//! rest of the chain, `Next`, and decides what happens: pass the request on, answer it itself,
//! or change the response on its way back.

use std::sync::Arc;
use std::time::Instant;

use crate::handlers::{BoxFuture, Handler};
use crate::http::{Method, Request, Response, StatusCode};

/// A step of the pipeline.
pub trait Middleware: Send + Sync {
    fn handle<'a>(&'a self, req: Request, next: Next<'a>) -> BoxFuture<'a, Response>;
}

/// The rest of the pipeline after a middleware, ending in the route's handler.
pub struct Next<'a> {
    endpoint: &'a Handler,
    rest: &'a [Arc<dyn Middleware>],
}

impl<'a> Next<'a> {
    pub fn new(endpoint: &'a Handler, rest: &'a [Arc<dyn Middleware>]) -> Self {
        Next { endpoint, rest }
    }

    /// Runs the rest of the pipeline on the request.
    pub fn run(self, req: Request) -> BoxFuture<'a, Response> {
        match self.rest.split_first() {
            Some((first, rest)) => first.handle(req, Next { endpoint: self.endpoint, rest }),
            None => (self.endpoint)(req),
        }
    }
}

/// Prints a line for each request: method, path, status and how long the answer took.
pub struct Logger;

impl Middleware for Logger {
    fn handle<'a>(&'a self, req: Request, next: Next<'a>) -> BoxFuture<'a, Response> {
        Box::pin(async move {
            let started = Instant::now();
            let line = format!("{} {}", req.method, req.path);
            let response = next.run(req).await;
            println!("{} -> {} ({} ms)", line, response.status.as_u16(), started.elapsed().as_millis());
            response
        })
    }
}

/// Lets pages from other origins call the server (Cross-Origin Resource Sharing), and answers
/// their preflight `OPTIONS` requests.
pub struct Cors {
    allow_origin: String,
}

impl Cors {
    pub fn new(allow_origin: &str) -> Self {
        Cors { allow_origin: allow_origin.to_string() }
    }

    /// Any origin may call.
    pub fn permissive() -> Self {
        Cors::new("*")
    }
}

impl Middleware for Cors {
    fn handle<'a>(&'a self, req: Request, next: Next<'a>) -> BoxFuture<'a, Response> {
        Box::pin(async move {
            let response = if req.method == Method::Options {
                Response::new(StatusCode::NO_CONTENT)
            } else {
                next.run(req).await
            };
            response
                .with_header("Access-Control-Allow-Origin", self.allow_origin.as_str())
                .with_header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, PATCH, OPTIONS")
                .with_header("Access-Control-Allow-Headers", "Content-Type, Authorization")
        })
    }
}
