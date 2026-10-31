# Reading and writing YAML with the standard library.
require "yaml"

src = <<~YAML
  app:
    name: inventory
    version: 1.4
    debug: false
  servers:
    - host: alpha.local
      port: 8080
    - host: beta.local
      port: 8081
  limits: { users: 50, items: 1000 }
YAML

config = YAML.safe_load(src)
puts config["app"]["name"]
puts config["app"]["version"].class
puts config["servers"].map { |s| "#{s['host']}:#{s['port']}" }.join(", ")
puts config["limits"].values.sum
config["servers"] << { "host" => "gamma.local", "port" => 8082 }
config["app"]["debug"] = true
puts config.to_yaml
puts YAML.safe_load("[1, two, 3.0, true, null]").inspect
