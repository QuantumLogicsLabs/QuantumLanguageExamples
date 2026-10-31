# Common validation patterns.
PATTERNS = {
  zip: /\A\d{5}(?:-\d{4})?\z/,
  phone: /\A\(?\d{3}\)?[-. ]?\d{3}[-. ]?\d{4}\z/,
  hex_color: /\A#(?:\h{3}|\h{6})\z/,
  date: /\A\d{4}-(?:0[1-9]|1[0-2])-(?:0[1-9]|[12]\d|3[01])\z/,
  time: /\A(?:[01]\d|2[0-3]):[0-5]\d\z/,
  username: /\A[a-z][a-z0-9_]{2,15}\z/
}.freeze

def ipv4?(s) = s.match?(/\A(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\z/) && s.split(".").all? { |o| o.to_i <= 255 }

samples = {
  zip: %w[12345 12345-6789 1234 123456],
  phone: ["(555) 123-4567", "555.123.4567", "5551234567", "55-1234-567"],
  hex_color: %w[#fff #A1B2C3 #ggg #1234],
  date: %w[2024-02-29 2024-13-01 2024-00-10 1999-12-31],
  time: %w[00:00 23:59 24:00 7:30],
  username: %w[ruby_fan r2 Admin user_with_a_very_long_name ok_name]
}
samples.each do |kind, values|
  puts "#{kind}: " + values.map { |v| "#{v}=#{v.match?(PATTERNS[kind]) ? 'ok' : 'no'}" }.join(", ")
end
%w[192.168.0.1 256.1.1.1 10.0.0 8.8.8.8].each { |ip| puts "#{ip}: #{ipv4?(ip)}" }
