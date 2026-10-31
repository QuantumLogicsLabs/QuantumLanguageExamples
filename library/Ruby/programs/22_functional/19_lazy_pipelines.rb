# Lazy pipelines that stop as soon as they have enough.
calls = Hash.new(0)
expensive = ->(n) { calls[:square] += 1; n * n }

eager = (1..1000).map(&expensive).select(&:even?).first(3)
puts "eager: #{eager.inspect}, squares computed: #{calls[:square]}"
calls.clear
lazy = (1..1000).lazy.map(&expensive).select(&:even?).first(3)
puts "lazy:  #{lazy.inspect}, squares computed: #{calls[:square]}"

words = %w[apple banana cherry date elderberry fig grape honeydew].lazy
long_upper = words.select { |w| w.size > 5 }.map(&:upcase)
puts long_upper.first(2).inspect
puts long_upper.to_a.size
naturals = (1..Float::INFINITY).lazy
pythagorean = naturals.flat_map { |c| (1...c).lazy.flat_map { |b| (1..b).lazy.select { |a| a * a + b * b == c * c }.map { |a| [a, b, c] } } }
puts pythagorean.first(4).inspect
puts naturals.map { |n| n * 3 }.reject(&:even?).each_slice(2).first(2).inspect
