# Folding collections with reduce/inject.
nums = [4, 8, 15, 16, 23, 42]
puts nums.reduce(:+)
puts nums.inject { |a, b| a * b }
puts nums.reduce(100) { |acc, n| acc - n }
puts nums.reduce { |a, b| a > b ? a : b }
puts nums.inject(0) { |count, n| n.even? ? count + 1 : count }

words = %w[ruby is a delight to use]
puts words.reduce { |longest, w| w.length > longest.length ? w : longest }
puts words.inject("") { |acc, w| acc + w[0] }
lengths = words.reduce({}) { |h, w| h.merge(w => w.length) }
puts lengths.inspect

running = nums.each_with_object([]) { |n, acc| acc << (acc.last || 0) + n }
puts running.inspect
puts (1..5).reduce(1, :*)
puts [[1, 2], [3, 4], [5, 6]].reduce([]) { |acc, pair| acc + pair }.inspect
puts %w[a b c].reduce { |acc, s| s + acc }
