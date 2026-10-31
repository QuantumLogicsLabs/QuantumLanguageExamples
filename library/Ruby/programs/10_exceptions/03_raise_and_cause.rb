# Re-raising, wrapping errors and the cause chain.
class ConfigError < StandardError; end

def parse_port(text)
  Integer(text)
rescue ArgumentError
  raise ConfigError, "port must be a number, got #{text.inspect}"
end

def load_config(settings)
  { port: parse_port(settings.fetch("port")), host: settings.fetch("host") }
end

[{ "port" => "8080", "host" => "local" }, { "port" => "eighty" }, { "port" => "1" }].each do |s|
  puts load_config(s).inspect
rescue ConfigError => e
  puts "ConfigError: #{e.message} (caused by #{e.cause.class})"
rescue KeyError => e
  puts "KeyError: #{e.message}"
end

def strict_sqrt(x)
  raise ArgumentError, "negative input" if x.negative?
  Math.sqrt(x)
end

begin
  begin
    strict_sqrt(-4)
  rescue ArgumentError => e
    puts "inner: #{e.message}"
    raise
  end
rescue => e
  puts "outer: #{e.class} again"
end
