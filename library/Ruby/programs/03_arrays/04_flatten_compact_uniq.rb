# Nested arrays, nils and duplicates.
nested = [1, [2, [3, [4, nil]]], nil, [5, 5], 2]
puts nested.flatten.inspect
puts nested.flatten(1).inspect
puts nested.flatten.compact.inspect
puts nested.flatten.compact.uniq.inspect
puts nested.flatten.compact.uniq.sort.inspect

words = %w[Apple apple BANANA banana Cherry]
puts words.uniq.inspect
puts words.uniq(&:downcase).inspect

matrix = [[1, 2], [3, 4], [5, 6]]
puts matrix.flatten.sum
puts matrix.map(&:sum).inspect
puts matrix.flat_map { |a, b| [a * 10, b * 10] }.inspect
puts [nil, false, 0, ""].compact.inspect
