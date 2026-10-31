# Everyday String methods.
s = "Ruby is a programmer's best friend"

puts s.length
puts s.upcase
puts s.downcase
puts s.swapcase
puts s.capitalize
puts s.reverse
puts s.include?("best")
puts s.start_with?("Ruby")
puts s.end_with?("enemy")
puts s.index("is")
puts s.count("aeiou")
puts s.split.length
puts s.sub("best", "favourite")
puts s.tr("aeiou", "*")
puts s.delete("aeiou")
puts s.squeeze
puts s * 2 if s.length < 10
puts "-" * s.length
