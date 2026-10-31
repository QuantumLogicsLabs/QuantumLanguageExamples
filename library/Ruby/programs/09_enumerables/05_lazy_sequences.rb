# Lazy enumerators over infinite ranges.
squares = (1..Float::INFINITY).lazy.map { |n| n * n }
puts squares.first(8).inspect
puts squares.select(&:even?).first(5).inspect
puts squares.take_while { |s| s < 200 }.to_a.inspect

primes = (2..).lazy.select { |n| (2..Integer.sqrt(n)).none? { |d| (n % d).zero? } }
puts primes.first(15).inspect
puts primes.map { |p| p * p }.reject(&:even?).first(4).inspect

triangular = (1..).lazy.map { |n| n * (n + 1) / 2 }
puts triangular.find { |t| t > 1000 }
puts triangular.each_slice(3).first(2).inspect
words = %w[apple banana cherry date elderberry fig grape].lazy
puts words.map(&:upcase).select { |w| w.length > 5 }.first(2).inspect
puts (1..20).lazy.filter_map { |n| n * 3 if n.odd? }.to_a.inspect
