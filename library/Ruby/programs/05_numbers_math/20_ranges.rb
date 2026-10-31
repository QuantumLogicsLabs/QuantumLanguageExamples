# Ranges: inclusion, stepping and arithmetic.
r = 1..10
puts r.to_a.inspect
puts (1...10).to_a.size
puts r.include?(5)
puts r.cover?(2..4)
puts r.sum
puts r.reduce(:*)
puts r.step(3).to_a.inspect
puts r.select(&:even?).inspect
puts r.minmax.inspect
puts ("a".."e").to_a.join
puts (1.0..2.0).include?(1.5)
puts (1..).first(3).inspect
puts (1..Float::INFINITY).lazy.map { |x| x * x }.select(&:odd?).first(5).inspect
puts ((1..10) % 4).to_a.inspect
puts (10..1).to_a.inspect
puts 10.downto(1).to_a.inspect
puts r.each_slice(4).map(&:sum).inspect
puts (1..100).count { |n| n % 7 == 0 }
