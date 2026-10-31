# Matching deeply nested API responses.
RESPONSES = [
  { status: 200, body: { data: { user: { id: 1, name: "Ana", roles: ["admin"] } } } },
  { status: 200, body: { data: { user: { id: 2, name: "Ben", roles: [] } } } },
  { status: 200, body: { data: { items: [{ id: 9 }, { id: 10 }] } } },
  { status: 404, body: { error: "not found" } },
  { status: 500, body: { error: "boom", retry_after: 30 } },
  { status: 301, headers: { location: "/new" } }
].freeze

def summarize(resp)
  case resp
  in { status: 200, body: { data: { user: { name:, roles: [_, *] => roles } } } }
    "#{name} has roles #{roles.join(', ')}"
  in { status: 200, body: { data: { user: { name: } } } }
    "#{name} has no roles"
  in { status: 200, body: { data: { items: [*, { id: } => last] } } }
    "list ending with id #{id} (#{last})"
  in { status: 400..499, body: { error: } }
    "client error: #{error}"
  in { status: 500.., body: { retry_after: Integer => secs } }
    "server error, retry in #{secs}s"
  in { status: 300...400, headers: { location: } }
    "redirect to #{location}"
  end
end

RESPONSES.each { |r| puts summarize(r) }
