# Hash defaults: values and blocks.
counts = Hash.new(0)
"mississippi".each_char { |c| counts[c] += 1 }
puts counts.inspect
puts counts["z"]
puts counts.key?("z")

lists = Hash.new { |hash, key| hash[key] = [] }
[["fruit", "apple"], ["veg", "kale"], ["fruit", "fig"]].each { |kind, name| lists[kind] << name }
puts lists.inspect

squares = Hash.new { |hash, n| hash[n] = n * n }
puts squares[12]
puts squares.inspect

shared = Hash.new([])
shared[:a] += [1]
shared[:b] += [2]
puts shared.inspect
puts shared[:missing].inspect
puts Hash.new(5).default
