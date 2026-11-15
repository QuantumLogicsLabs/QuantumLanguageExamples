//! Routing: which handler answers which method and path. A pattern can have parameters
//! (`/users/:id`) and end in a wildcard (`/static/*`); the handler reads them with `req.param`.

use std::collections::HashMap;
use std::fmt;

use crate::handlers::Handler;
use crate::http::Method;

#[derive(Debug, Clone, PartialEq)]
enum Segment {
    Literal(String),
    Param(String),
    Wildcard,
}

fn split_path(path: &str) -> Vec<&str> {
    path.split('/').filter(|part| !part.is_empty()).collect()
}

/// A route: a method, a path pattern and the handler that answers it.
#[derive(Clone)]
pub struct Route {
    pub method: Method,
    pub pattern: String,
    segments: Vec<Segment>,
    handler: Handler,
}

impl Route {
    pub fn new(method: Method, pattern: &str, handler: Handler) -> Self {
        let segments = split_path(pattern)
            .into_iter()
            .map(|part| {
                if part == "*" {
                    Segment::Wildcard
                } else if let Some(name) = part.strip_prefix(':') {
                    Segment::Param(name.to_string())
                } else {
                    Segment::Literal(part.to_string())
                }
            })
            .collect();
        Route { method, pattern: pattern.to_string(), segments, handler }
    }

    /// The route's parameters when `path` matches its pattern (the wildcard's part is `"*"`).
    pub fn matches(&self, path: &str) -> Option<HashMap<String, String>> {
        let parts = split_path(path);
        let mut params = HashMap::new();
        for (i, segment) in self.segments.iter().enumerate() {
            match segment {
                Segment::Wildcard => {
                    params.insert("*".to_string(), parts[i.min(parts.len())..].join("/"));
                    return Some(params);
                }
                Segment::Literal(text) => {
                    if parts.get(i) != Some(&text.as_str()) {
                        return None;
                    }
                }
                Segment::Param(name) => {
                    params.insert(name.clone(), parts.get(i)?.to_string());
                }
            }
        }
        if parts.len() == self.segments.len() {
            Some(params)
        } else {
            None
        }
    }

    pub fn handler(&self) -> &Handler {
        &self.handler
    }
}

impl fmt::Debug for Route {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("Route").field("method", &self.method).field("pattern", &self.pattern).finish()
    }
}

/// What the router found for a request.
pub enum RouteMatch<'a> {
    Found(&'a Route, HashMap<String, String>),
    /// The path has routes, but not for this method: these are the methods it has.
    MethodNotAllowed(Vec<Method>),
    NotFound,
}

/// The routes of a server, tried in the order they were added.
#[derive(Clone, Default)]
pub struct Router {
    routes: Vec<Route>,
}

impl Router {
    pub fn new() -> Self {
        Router { routes: Vec::new() }
    }

    pub fn add(&mut self, method: Method, pattern: &str, handler: Handler) -> &mut Self {
        self.routes.push(Route::new(method, pattern, handler));
        self
    }

    pub fn routes(&self) -> &[Route] {
        &self.routes
    }

    /// The route for a request. A `HEAD` request is answered by the `GET` route of its path.
    pub fn find(&self, method: Method, path: &str) -> RouteMatch<'_> {
        let mut allowed = Vec::new();
        for route in &self.routes {
            if let Some(params) = route.matches(path) {
                if route.method == method || (method == Method::Head && route.method == Method::Get) {
                    return RouteMatch::Found(route, params);
                }
                if !allowed.contains(&route.method) {
                    allowed.push(route.method);
                }
            }
        }
        if allowed.is_empty() {
            RouteMatch::NotFound
        } else {
            RouteMatch::MethodNotAllowed(allowed)
        }
    }

    /// Adds every route of `other` under `prefix`: `/api` and `/users` give `/api/users`.
    pub fn nest(&mut self, prefix: &str, other: Router) -> &mut Self {
        for route in other.routes {
            let pattern = format!("{}{}", prefix.trim_end_matches('/'), route.pattern);
            self.routes.push(Route::new(route.method, &pattern, route.handler));
        }
        self
    }
}
