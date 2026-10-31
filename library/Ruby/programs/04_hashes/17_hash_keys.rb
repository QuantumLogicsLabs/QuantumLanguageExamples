# Keys of different types, equality and comparison.
h = { 1 => "int", 1.0 => "float", "1" => "string", :one => "symbol", [1, 2] => "array", nil => "nil" }
h.each { |k, v| puts "#{k.inspect} (#{k.class}) => #{v}" }
puts h[[1, 2]]
puts h[1]
puts h[1.0]
puts 1.eql?(1.0)
puts 1 == 1.0

a = { x: 1, y: 2 }
b = { y: 2, x: 1 }
puts a == b
puts a.to_a == b.to_a
puts({ "x" => 1 } == { x: 1 })
puts a.compare_by_identity.class
puts a.keys.map(&:class).uniq.inspect
puts({ b: 1, a: 2 }.min_by { |k, _| k }.inspect)
