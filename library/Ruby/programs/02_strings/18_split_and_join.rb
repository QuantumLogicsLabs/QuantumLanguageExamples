# Splitting strings in different ways.
csv = "red,green,,blue,"
puts csv.split(",").inspect
puts csv.split(",", -1).inspect
puts "a b  c".split.inspect
puts "a b  c".split(" ").inspect
puts "a b  c".split(/ /).inspect
puts "1-2_3 4".split(/[-_ ]/).inspect
puts "key=value=more".split("=", 2).inspect
puts "chars".split("").inspect

lines = "first line\nsecond line\nthird line"
puts lines.lines.map(&:chomp).inspect
puts lines.each_line.count

path = "/usr/local/lib/ruby"
parts = path.split("/").reject(&:empty?)
puts parts.inspect
puts parts.join(" > ")
