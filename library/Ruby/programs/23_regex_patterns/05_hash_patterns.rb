# case/in with hash patterns and nested data.
EVENTS = [
  { type: "click", x: 10, y: 20, button: "left" },
  { type: "key", key: "Enter", modifiers: ["ctrl"] },
  { type: "key", key: "a", modifiers: [] },
  { type: "scroll", delta: -3 },
  { type: "resize", size: { w: 1920, h: 1080 } },
  { type: "unknown" }
].freeze

def handle(event)
  case event
  in { type: "click", button: "left", x:, y: } then "left click at #{x},#{y}"
  in { type: "key", key: "Enter", modifiers: [*, "ctrl", *] } then "ctrl+enter submit"
  in { type: "key", key: String => k } then "typed #{k}"
  in { type: "scroll", delta: Integer => d } if d.negative? then "scroll up #{-d}"
  in { type: "resize", size: { w:, h: } } then "resized to #{w}x#{h} (#{(w.fdiv(h)).round(2)})"
  in { type: } then "unhandled #{type}"
  end
end

EVENTS.each { |e| puts handle(e) }

config = { db: { user: "admin", port: 5432 }, mode: "prod" }
case config
in { db: { port: Integer => port }, mode: "prod" | "staging" => mode }
  puts "#{mode} database on port #{port}"
end
