# Set operations.
require "set"

a = Set[1, 2, 3, 4]
b = Set.new([3, 4, 5, 6])
puts (a | b).to_a.inspect
puts (a & b).to_a.inspect
puts (a - b).to_a.inspect
puts (a ^ b).to_a.sort.inspect
puts a.include?(2)
puts a.size
a << 2
a.add(7)
puts a.size
puts a.subset?(Set[1, 2, 3, 4, 7, 9])
puts Set[1, 2].proper_subset?(a)
puts a.disjoint?(Set[100])
puts a.to_a.sort.inspect
puts Set["x", "y"] == Set["y", "x"]
puts a.map { |x| x % 3 }.to_set.sort.inspect
puts a.group_by(&:odd?).transform_values(&:sort).inspect
