//! Server-side rendering with a small template language: `{{ name }}` is replaced by the value
//! of `name`, HTML-escaped; `{{{ name }}}` puts the value in as it is.

use std::collections::HashMap;

use crate::security::escape_html;

#[derive(Debug, Clone)]
enum Part {
    Text(String),
    Var { name: String, raw: bool },
}

/// A parsed template.
#[derive(Debug, Clone)]
pub struct Template {
    parts: Vec<Part>,
}

impl Template {
    pub fn new(source: &str) -> Self {
        let mut parts = Vec::new();
        let mut rest = source;
        while let Some(open) = rest.find("{{") {
            let raw = rest[open..].starts_with("{{{");
            let (start, close_tag) = if raw { (open + 3, "}}}") } else { (open + 2, "}}") };
            match rest[start..].find(close_tag) {
                Some(length) => {
                    if open > 0 {
                        parts.push(Part::Text(rest[..open].to_string()));
                    }
                    let name = rest[start..start + length].trim().to_string();
                    parts.push(Part::Var { name, raw });
                    rest = &rest[start + length + close_tag.len()..];
                }
                // no closing braces: the rest is text
                None => break,
            }
        }
        if !rest.is_empty() {
            parts.push(Part::Text(rest.to_string()));
        }
        Template { parts }
    }

    /// The template filled in; a name without a value becomes empty text.
    pub fn render(&self, values: &HashMap<String, String>) -> String {
        let mut out = String::new();
        for part in &self.parts {
            match part {
                Part::Text(text) => out.push_str(text),
                Part::Var { name, raw } => {
                    let value = values.get(name).map(|value| value.as_str()).unwrap_or("");
                    if *raw {
                        out.push_str(value);
                    } else {
                        out.push_str(&escape_html(value));
                    }
                }
            }
        }
        out
    }

    /// The names the template uses, in order.
    pub fn variables(&self) -> Vec<&str> {
        self.parts
            .iter()
            .filter_map(|part| match part {
                Part::Var { name, .. } => Some(name.as_str()),
                Part::Text(_) => None,
            })
            .collect()
    }
}

/// Templates by name, for handlers to render.
#[derive(Debug, Clone, Default)]
pub struct Templates {
    templates: HashMap<String, Template>,
}

impl Templates {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn add(&mut self, name: &str, source: &str) -> &mut Self {
        self.templates.insert(name.to_string(), Template::new(source));
        self
    }

    /// The named template filled in; None when there is no such template.
    pub fn render(&self, name: &str, values: &HashMap<String, String>) -> Option<String> {
        self.templates.get(name).map(|template| template.render(values))
    }
}

/// The values for a template, written `context(&[("name", "Ada"), ("role", "admin")])`.
pub fn context(pairs: &[(&str, &str)]) -> HashMap<String, String> {
    pairs.iter().map(|(name, value)| (name.to_string(), value.to_string())).collect()
}
