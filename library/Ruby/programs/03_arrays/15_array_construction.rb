# Array.new, fill, ranges and %w.
puts Array.new(3).inspect
puts Array.new(3, 0).inspect
puts Array.new(5) { |i| i * i }.inspect
puts Array(1..4).inspect
puts (1..10).step(3).to_a.inspect
puts %w[x y z].inspect
puts Array.new(2) { Array.new(3, ".") }.map(&:join).inspect

grid = Array.new(3) { [] }
grid[0] << 1
puts grid.inspect

a = [1, 2, 3, 4, 5]
a.fill(0, 2)
puts a.inspect
puts Array.new(4).fill { |i| (i + 1) * 10 }.inspect
puts [0] * 4 == Array.new(4, 0)
puts [[1, :a], [2, :b]].to_h.inspect
