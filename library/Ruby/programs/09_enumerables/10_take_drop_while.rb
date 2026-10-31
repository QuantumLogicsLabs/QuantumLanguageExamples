# take, drop, take_while and drop_while.
readings = [3, 5, 8, 13, 21, 7, 4, 30, 2]
puts readings.take(3).inspect
puts readings.drop(6).inspect
puts readings.take_while { |r| r < 20 }.inspect
puts readings.drop_while { |r| r < 20 }.inspect
puts readings.find_all { |r| r > 10 }.inspect
puts readings.first(4).inspect
puts readings.last(2).inspect

text = "   leading spaces and words"
puts text.chars.drop_while { |c| c == " " }.join

header, *body = ["Name,Age", "ann,31", "bob,25"]
puts header
puts body.inspect
data = %w[# comment # another value1 value2 # trailing]
puts data.drop_while { |x| x == "#" || x == "comment" || x == "another" }.take_while { |x| x != "#" }.inspect
