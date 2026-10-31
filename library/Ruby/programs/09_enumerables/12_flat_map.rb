# Flattening as you map.
sentences = ["the cat sat", "a dog ran far", "birds sing"]
words = sentences.flat_map(&:split)
puts words.inspect
puts words.size

pairs = (1..3).flat_map { |a| (a..3).map { |b| [a, b] } }
puts pairs.inspect

orders = { "ana" => %w[pen ink], "ben" => %w[pad], "cy" => [] }
puts orders.flat_map { |name, items| items.map { |i| "#{name}:#{i}" } }.inspect

tree = { value: 1, children: [{ value: 2, children: [{ value: 4, children: [] }] }, { value: 3, children: [] }] }
values = ->(node) { [node[:value]] + node[:children].flat_map { |c| values.(c) } }
puts values.(tree).inspect

puts [[1, [2]], [3]].flat_map { |x| x }.inspect
puts %w[ab cd].flat_map(&:chars).inspect
