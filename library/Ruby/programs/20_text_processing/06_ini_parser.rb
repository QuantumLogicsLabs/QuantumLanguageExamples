# Parsing INI-style configuration with sections and types.
INI = <<~INI
  ; global settings
  name = demo app
  debug = true

  [server]
  host = 127.0.0.1
  port = 8080
  timeout = 2.5

  [database]
  user = admin
  pool = 5
  ; password set elsewhere
  replicas = db1, db2, db3
INI

def coerce(v)
  case v
  when /\A\d+\z/ then v.to_i
  when /\A\d+\.\d+\z/ then v.to_f
  when "true", "false" then v == "true"
  when /,/ then v.split(",").map(&:strip)
  else v
  end
end

config = { "global" => {} }
section = "global"
INI.each_line(chomp: true) do |line|
  line = line.strip
  next if line.empty? || line.start_with?(";")
  if line =~ /\A\[(\w+)\]\z/
    section = $1
    config[section] = {}
  else
    key, value = line.split("=", 2).map(&:strip)
    config[section][key] = coerce(value)
  end
end

config.each do |sec, values|
  puts "[#{sec}]"
  values.each { |k, v| puts "  #{k} = #{v.inspect} (#{v.class})" }
end
puts "server url: http://#{config.dig('server', 'host')}:#{config.dig('server', 'port')}"
