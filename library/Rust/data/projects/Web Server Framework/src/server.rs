//! The server: routes and middleware are set up first, then `listen` accepts connections and
//! answers each one on a task of its own.

use std::future::Future;
use std::sync::Arc;
use std::time::Duration;

use tokio::io::{AsyncReadExt, AsyncWriteExt};
use tokio::net::{TcpListener, TcpStream};

use crate::config;
use crate::error::{Error, Result};
use crate::handlers::{self, handler, Handler};
use crate::http::{head_end, Method, Request, Response, StatusCode};
use crate::middleware::{Middleware, Next};
use crate::router::{RouteMatch, Router};

/// How the server behaves.
#[derive(Debug, Clone)]
pub struct ServerConfig {
    pub addr: String,
    pub workers: usize,
    /// How long a client may take to send its request.
    pub timeout: Duration,
    /// The largest request accepted, head and body, in bytes.
    pub max_request_size: usize,
}

impl Default for ServerConfig {
    fn default() -> Self {
        ServerConfig {
            addr: config::DEFAULT_ADDR.to_string(),
            workers: config::DEFAULT_WORKERS,
            timeout: Duration::from_secs(config::DEFAULT_TIMEOUT),
            max_request_size: config::DEFAULT_MAX_REQUEST_SIZE,
        }
    }
}

/// Builds a `Server` with other settings than the defaults.
#[derive(Debug, Clone, Default)]
pub struct ServerBuilder {
    config: ServerConfig,
}

impl ServerBuilder {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn addr(mut self, addr: &str) -> Self {
        self.config.addr = addr.to_string();
        self
    }

    pub fn workers(mut self, workers: usize) -> Self {
        self.config.workers = workers.max(1);
        self
    }

    pub fn timeout(mut self, timeout: Duration) -> Self {
        self.config.timeout = timeout;
        self
    }

    pub fn max_request_size(mut self, bytes: usize) -> Self {
        self.config.max_request_size = bytes;
        self
    }

    pub fn build(self) -> Server {
        Server {
            router: Router::new(),
            middleware: Vec::new(),
            fallback: handler(handlers::not_found),
            config: self.config,
        }
    }
}

/// A web server: its routes, its middleware and its settings.
pub struct Server {
    router: Router,
    middleware: Vec<Arc<dyn Middleware>>,
    fallback: Handler,
    config: ServerConfig,
}

impl Default for Server {
    fn default() -> Self {
        Server::new()
    }
}

impl Server {
    /// A server with the default settings (see `crate::config`).
    pub fn new() -> Self {
        ServerBuilder::new().build()
    }

    pub fn builder() -> ServerBuilder {
        ServerBuilder::new()
    }

    pub fn config(&self) -> &ServerConfig {
        &self.config
    }

    pub fn router(&self) -> &Router {
        &self.router
    }

    /// Adds a route: `method` and a path pattern (`/users/:id`, `/static/*`) to an async handler.
    pub fn route<F, Fut>(&mut self, method: Method, path: &str, f: F) -> &mut Self
    where
        F: Fn(Request) -> Fut + Send + Sync + 'static,
        Fut: Future<Output = Response> + Send + 'static,
    {
        self.router.add(method, path, handler(f));
        self
    }

    pub fn get<F, Fut>(&mut self, path: &str, f: F) -> &mut Self
    where
        F: Fn(Request) -> Fut + Send + Sync + 'static,
        Fut: Future<Output = Response> + Send + 'static,
    {
        self.route(Method::Get, path, f)
    }

    pub fn post<F, Fut>(&mut self, path: &str, f: F) -> &mut Self
    where
        F: Fn(Request) -> Fut + Send + Sync + 'static,
        Fut: Future<Output = Response> + Send + 'static,
    {
        self.route(Method::Post, path, f)
    }

    pub fn put<F, Fut>(&mut self, path: &str, f: F) -> &mut Self
    where
        F: Fn(Request) -> Fut + Send + Sync + 'static,
        Fut: Future<Output = Response> + Send + 'static,
    {
        self.route(Method::Put, path, f)
    }

    pub fn delete<F, Fut>(&mut self, path: &str, f: F) -> &mut Self
    where
        F: Fn(Request) -> Fut + Send + Sync + 'static,
        Fut: Future<Output = Response> + Send + 'static,
    {
        self.route(Method::Delete, path, f)
    }

    pub fn patch<F, Fut>(&mut self, path: &str, f: F) -> &mut Self
    where
        F: Fn(Request) -> Fut + Send + Sync + 'static,
        Fut: Future<Output = Response> + Send + 'static,
    {
        self.route(Method::Patch, path, f)
    }

    /// Mounts a ready-made handler (`handlers::static_files(..)` ...) on a route.
    pub fn mount(&mut self, method: Method, path: &str, handler: Handler) -> &mut Self {
        self.router.add(method, path, handler);
        self
    }

    /// Adds every route of `router` under `prefix`.
    pub fn nest(&mut self, prefix: &str, router: Router) -> &mut Self {
        self.router.nest(prefix, router);
        self
    }

    /// Adds a middleware. They run in the order they were added, around every request.
    pub fn use_middleware<M: Middleware + 'static>(&mut self, middleware: M) -> &mut Self {
        self.middleware.push(Arc::new(middleware));
        self
    }

    /// What answers the requests no route matches (404 Not Found unless set).
    pub fn fallback<F, Fut>(&mut self, f: F) -> &mut Self
    where
        F: Fn(Request) -> Fut + Send + Sync + 'static,
        Fut: Future<Output = Response> + Send + 'static,
    {
        self.fallback = handler(f);
        self
    }

    /// Answers one request: its route's handler (or the fallback), through the middleware. This is
    /// what `listen` does for each request, and it needs no network: tests call it directly.
    pub async fn handle(&self, mut req: Request) -> Response {
        let endpoint = match self.router.find(req.method, &req.path) {
            RouteMatch::Found(route, params) => {
                req.params = params;
                route.handler().clone()
            }
            RouteMatch::MethodNotAllowed(allowed) => {
                let methods: Vec<String> = allowed.iter().map(|method| method.to_string()).collect();
                let allow = methods.join(", ");
                handler(move |_req: Request| {
                    let allow = allow.clone();
                    async move {
                        Response::error(StatusCode::METHOD_NOT_ALLOWED, "That method is not allowed here.")
                            .with_header("Allow", allow)
                    }
                })
            }
            RouteMatch::NotFound => self.fallback.clone(),
        };
        let head_only = req.method == Method::Head;
        let mut response = Next::new(&endpoint, &self.middleware).run(req).await;
        if head_only {
            // the head of the GET answer, without its body
            let length = response.body.len().to_string();
            response.set_header("Content-Length", length);
            response.body.clear();
        }
        response
    }

    /// Binds `addr` and serves until the process ends.
    pub async fn listen(self, addr: &str) -> Result<()> {
        let listener = TcpListener::bind(addr).await?;
        println!("Listening on http://{}", listener.local_addr()?);
        self.serve(listener).await
    }

    /// Serves the connections `listener` accepts, each on a task of its own.
    pub async fn serve(self, listener: TcpListener) -> Result<()> {
        let server = Arc::new(self);
        loop {
            let (stream, peer) = listener.accept().await?;
            let server = Arc::clone(&server);
            tokio::spawn(async move {
                if let Err(e) = server.serve_connection(stream, peer.to_string()).await {
                    eprintln!("connection from {}: {}", peer, e);
                }
            });
        }
    }

    /// One connection: read a request, answer it, close.
    async fn serve_connection(&self, mut stream: TcpStream, peer: String) -> Result<()> {
        let limit = self.config.max_request_size;
        let response = match tokio::time::timeout(self.config.timeout, read_request(&mut stream, limit)).await {
            Ok(Ok(mut req)) => {
                req.remote_addr = Some(peer);
                self.handle(req).await
            }
            Ok(Err(e)) => Response::error(e.status(), &e.to_string()),
            Err(_) => Response::error(StatusCode::REQUEST_TIMEOUT, &Error::Timeout.to_string()),
        };
        stream.write_all(&response.with_header("Connection", "close").to_bytes()).await?;
        stream.shutdown().await?;
        Ok(())
    }
}

/// Reads one request from a connection: the head, then as much body as its Content-Length says.
async fn read_request(stream: &mut TcpStream, limit: usize) -> Result<Request> {
    let mut raw = Vec::new();
    let mut buf = [0u8; 4096];
    loop {
        match head_end(&raw) {
            Some(end) => {
                let total = end + Request::parse(&raw[..end])?.content_length();
                if total > limit {
                    return Err(Error::PayloadTooLarge(total));
                }
                if raw.len() >= total {
                    raw.truncate(total);
                    return Request::parse(&raw);
                }
            }
            None => {
                if raw.len() > limit {
                    return Err(Error::PayloadTooLarge(raw.len()));
                }
            }
        }
        let n = stream.read(&mut buf).await?;
        if n == 0 {
            return Err(Error::BadRequest("the connection closed before the request was complete".to_string()));
        }
        raw.extend_from_slice(&buf[..n]);
    }
}
