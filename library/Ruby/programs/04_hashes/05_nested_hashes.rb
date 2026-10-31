# Nested configuration with dig.
config = {
  database: { host: "localhost", port: 5432, credentials: { user: "app", password: "secret" } },
  cache: { enabled: true, ttl: 300 },
  features: ["search", "export"]
}

puts config[:database][:host]
puts config.dig(:database, :credentials, :user)
puts config.dig(:database, :replica, :host).inspect
puts config.dig(:features, 1)
puts config[:cache].fetch(:ttl)

def flatten_keys(hash, prefix = nil)
  hash.each_with_object({}) do |(key, value), out|
    name = prefix ? "#{prefix}.#{key}" : key.to_s
    if value.is_a?(Hash)
      out.merge!(flatten_keys(value, name))
    else
      out[name] = value
    end
  end
end

flatten_keys(config).each { |k, v| puts "#{k} = #{v.inspect}" }
