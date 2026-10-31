# All subsets of a set, recursively and with bitmasks.
def subsets(items)
  return [[]] if items.empty?
  rest = subsets(items[1..])
  rest + rest.map { |s| [items[0]] + s }
end

def subsets_bitmask(items)
  (0...2**items.size).map { |mask| items.select.with_index { |_, i| mask[i] == 1 } }
end

sets = subsets(%w[a b c])
puts sets.map { |s| "{#{s.join}}" }.join(" ")
puts subsets_bitmask(%w[a b c]).map { |s| "{#{s.join}}" }.join(" ")
puts subsets((1..10).to_a).size

coins = [3, 5, 7, 11]
target = 15
matches = subsets(coins).select { |s| s.sum == target }
puts "Subsets of #{coins.inspect} summing to #{target}: #{matches.inspect}"
best = subsets([8, 6, 5, 3]).select { |s| s.sum <= 14 }.max_by(&:sum)
puts "Best fit under 14: #{best.inspect} (#{best.sum})"
