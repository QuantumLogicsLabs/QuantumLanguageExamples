# Matching, captures and named groups.
s = "Order #4521 shipped on 2024-03-15 to Lima"

puts s =~ /\d+/
puts s.match?(/shipped/)
m = s.match(/#(\d+)/)
puts m[0], m[1]
puts m.pre_match
date = s.match(/(?<year>\d{4})-(?<month>\d\d)-(?<day>\d\d)/)
puts "#{date[:day]}/#{date[:month]}/#{date[:year]}"
puts date.names.inspect
puts date.captures.inspect
puts date.named_captures.inspect
if s =~ /to (\w+)/
  puts "destination: #{$1}"
end
puts s[/\d{4}/]
puts s[/on (\S+)/, 1]
puts (s =~ /missing/).inspect
puts s.match(/(\d+)\D+(\d+)/).values_at(1, 2).inspect
