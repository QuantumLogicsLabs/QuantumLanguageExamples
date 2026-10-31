# Building strings: <<, +, concat, * and join.
line = +""
%w[alpha beta gamma].each { |w| line << w << " " }
puts line.strip

greeting = "Hello" + ", " + "world"
puts greeting

buffer = String.new
buffer.concat("one", "-", "two")
puts buffer

puts "ab" * 3
puts ["x", "y", "z"].join("/")

rows = (1..3).map { |i| "row #{i}: " + ("*" * i) }
puts rows.join("\n")

csv = [["name", "qty"], ["pen", 3], ["ink", 12]].map { |r| r.join(",") }.join("\n")
puts csv
puts "frozen? #{'literal'.frozen?}"
