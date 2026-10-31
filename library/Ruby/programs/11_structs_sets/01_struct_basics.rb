# Struct: lightweight records.
Point = Struct.new(:x, :y)
p1 = Point.new(3, 4)
p2 = Point.new(3, 4)

puts p1.x
puts p1[:y]
puts p1[0]
puts p1 == p2
puts p1.to_a.inspect
puts p1.to_h.inspect
puts Point.members.inspect
p1.x = 10
puts p1.inspect
puts p1.each.to_a.inspect

Person = Struct.new(:name, :age, keyword_init: true)
ana = Person.new(name: "Ana", age: 31)
puts ana.name
puts ana.to_h.inspect

Pair = Struct.new(:left, :right)
partial = Pair.new(1)
puts partial.right.inspect
a, b = *Pair.new(:l, :r)
puts "#{a} #{b}"
