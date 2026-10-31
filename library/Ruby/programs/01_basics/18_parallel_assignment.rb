# Multiple assignment, swaps and splats.
a, b = 1, 2
puts "a=#{a} b=#{b}"
a, b = b, a
puts "swapped: a=#{a} b=#{b}"

first, *rest = [10, 20, 30, 40]
puts "first=#{first} rest=#{rest.inspect}"

*init, last = %w[x y z]
puts "init=#{init.inspect} last=#{last}"

head, (inner1, inner2), tail = 1, [2, 3], 4
puts "head=#{head} inner=#{inner1},#{inner2} tail=#{tail}"

def min_max(values)
  [values.min, values.max]
end

low, high = min_max([7, 2, 9, 4])
puts "low=#{low} high=#{high}"

x = y = 5
x += 1
puts "x=#{x} y=#{y}"

fib = [0, 1]
8.times { a, b = fib[-2], fib[-1]; fib << a + b }
puts "fib: #{fib.join(' ')}"
