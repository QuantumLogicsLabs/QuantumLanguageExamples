# Indexing and slicing strings.
s = "Hello, Ruby World"

puts s[0]
puts s[-1]
puts s[7, 4]
puts s[7..10]
puts s[7..]
puts s[..4]
puts s[-5..]
puts s.slice(0, 5)
puts s[100].inspect
puts s.chars.first(3).inspect
puts s.chars.last(3).join
puts s.each_char.select.with_index { |_, i| i.even? }.join

t = s.dup
t[0, 5] = "Howdy"
puts t
t["World"] = "Universe"
puts t
puts s
