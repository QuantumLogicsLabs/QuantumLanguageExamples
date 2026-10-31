# Parsing log lines and summarising them.
LOG = <<~LOG
  2024-03-01 09:15:02 INFO  [web] GET /index 200 12ms
  2024-03-01 09:15:07 INFO  [web] GET /about 200 8ms
  2024-03-01 09:16:44 WARN  [db] slow query 1450ms
  2024-03-01 10:02:13 ERROR [web] GET /checkout 500 230ms
  2024-03-01 10:05:51 INFO  [web] POST /login 302 41ms
  2024-03-01 10:06:02 ERROR [auth] token expired
  2024-03-01 11:30:00 INFO  [web] GET /index 200 15ms
  2024-03-01 11:31:09 WARN  [web] GET /search 200 980ms
LOG

LINE = /\A(?<date>\S+) (?<time>\d\d):\d\d:\d\d (?<level>\w+)\s+\[(?<comp>\w+)\] (?<msg>.*)\z/
entries = LOG.lines.map { |l| LINE.match(l.chomp) }.compact

puts "By level: #{entries.map { |e| e[:level] }.tally.inspect}"
puts "By hour:  #{entries.map { |e| e[:time] }.tally.inspect}"
puts "By component: #{entries.map { |e| e[:comp] }.tally.sort_by { |_, n| -n }.inspect}"
requests = entries.filter_map { |e| e[:msg].match(/(?<verb>GET|POST) (?<path>\S+) (?<status>\d+) (?<ms>\d+)ms/) }
puts "Requests: #{requests.size}, avg #{(requests.sum { |r| r[:ms].to_i } / requests.size.to_f).round(1)}ms"
puts "Slowest: #{requests.max_by { |r| r[:ms].to_i }[:path]}"
puts "Errors:"
entries.select { |e| e[:level] == "ERROR" }.each { |e| puts "  #{e[:time]}h #{e[:comp]}: #{e[:msg]}" }
