# Splitting arrays into groups.
numbers = (1..20).to_a

evens, odds = numbers.partition(&:even?)
puts "Evens: #{evens.inspect}"
puts "Odds:  #{odds.inspect}"

by_remainder = numbers.group_by { |n| n % 3 }
by_remainder.each { |r, list| puts "n % 3 == #{r}: #{list.inspect}" }

words = %w[apple avocado banana blueberry cherry cranberry date]
by_letter = words.group_by { |w| w[0] }
by_letter.each { |letter, list| puts "#{letter}: #{list.join(', ')}" }
puts words.group_by(&:length).transform_values(&:size).sort.inspect

small, big = words.partition { |w| w.length <= 6 }
puts "short: #{small.inspect}, long: #{big.inspect}"
