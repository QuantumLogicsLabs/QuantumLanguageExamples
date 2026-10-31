# Keeping sets in order, with sorting on demand.
tags = Set.new
%w[ruby web api ruby fast api db].each { |t| tags << t }
puts tags.to_a.inspect
puts tags.sort.inspect
puts tags.min
puts tags.sort_by(&:length).first

numbers = Set.new
[5, 3, 9, 3, 1, 9, 7].each { |n| numbers.add?(n) ? puts("added #{n}") : puts("dup #{n}") }
puts numbers.sort.inspect
puts numbers.sum
removed = numbers.delete?(3)
puts removed.nil? ? "nothing" : "removed 3"
puts numbers.reject(&:odd?).inspect
puts numbers.partition { |n| n > 5 }.map(&:sort).inspect
puts numbers.each_slice(2).map(&:sort).inspect
