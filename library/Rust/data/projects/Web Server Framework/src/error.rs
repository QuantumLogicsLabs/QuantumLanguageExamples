//! Errors of the framework, and the `Result` its fallible functions return.

use std::fmt;

use crate::http::StatusCode;

/// Everything that can go wrong while serving a request.
#[derive(Debug)]
pub enum Error {
    /// Reading from or writing to the connection failed.
    Io(std::io::Error),
    /// The request could not be understood.
    BadRequest(String),
    /// The request is bigger than the server accepts (its size in bytes).
    PayloadTooLarge(usize),
    /// The client took longer than the server waits.
    Timeout,
    /// A handler or a middleware failed.
    Internal(String),
}

impl Error {
    /// The HTTP status a client gets for this error.
    pub fn status(&self) -> StatusCode {
        match self {
            Error::Io(_) | Error::Internal(_) => StatusCode::INTERNAL_SERVER_ERROR,
            Error::BadRequest(_) => StatusCode::BAD_REQUEST,
            Error::PayloadTooLarge(_) => StatusCode::PAYLOAD_TOO_LARGE,
            Error::Timeout => StatusCode::REQUEST_TIMEOUT,
        }
    }
}

impl fmt::Display for Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Error::Io(e) => write!(f, "I/O error: {}", e),
            Error::BadRequest(why) => write!(f, "bad request: {}", why),
            Error::PayloadTooLarge(size) => write!(f, "a request of {} bytes is too large", size),
            Error::Timeout => write!(f, "the client took too long"),
            Error::Internal(why) => write!(f, "internal error: {}", why),
        }
    }
}

impl std::error::Error for Error {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        match self {
            Error::Io(e) => Some(e),
            _ => None,
        }
    }
}

impl From<std::io::Error> for Error {
    fn from(e: std::io::Error) -> Self {
        Error::Io(e)
    }
}

/// The framework's result type.
pub type Result<T> = std::result::Result<T, Error>;
