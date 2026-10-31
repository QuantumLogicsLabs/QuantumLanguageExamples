# Rewriting configuration with regex captures.
config = <<~CONF
  server.port=8080
  server.host=localhost
  db.url=postgres://localhost:5432/dev
  db.pool=5
  feature.beta=false
  log.level=debug
CONF

overrides = { "server.host" => "0.0.0.0", "db.pool" => "20", "log.level" => "info" }
updated = config.gsub(/^([\w.]+)=(.*)$/) do
  key, value = $1, $2
  overrides.key?(key) ? "#{key}=#{overrides[key]}  # was #{value}" : "#{key}=#{value}"
end
puts updated

renamed = config.gsub(/^db\./, "database.")
puts renamed.lines.grep(/database/).join

ports = config.scan(/:(\d{2,5})\b/).flatten.map(&:to_i)
puts "ports mentioned: #{ports.inspect}"
puts config.gsub(/(?<=\=)(true|false)$/) { $1 == "true" ? "on" : "off" }.lines.grep(/beta/).first
