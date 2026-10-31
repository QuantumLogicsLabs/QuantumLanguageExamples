# &:symbol shorthand and its equivalents.
words = %w[apple Banana cherry date]
puts words.map(&:upcase).inspect
puts words.map(&:length).inspect
puts words.select(&:frozen?).size
puts words.sort_by(&:downcase).inspect
puts words.map(&:capitalize).join(", ")
puts [1, 2, 3, 4].select(&:even?).inspect
puts [1, 2, 3, 4].inject(&:+)
puts [[1, 2], [3, 4]].map(&:sum).inspect
puts [3.7, 1.2, 9.9].map(&:round).inspect
puts %w[1 2 3].map(&:to_i).sum
puts [:a, :b].map(&:to_proc).map { |pr| pr.call("x") rescue "n/a" }.inspect
puts words.group_by(&:size).keys.inspect
puts (1..5).each_slice(2).map(&:sum).inspect
puts [nil, 1, false, 2].reject(&:nil?).inspect
