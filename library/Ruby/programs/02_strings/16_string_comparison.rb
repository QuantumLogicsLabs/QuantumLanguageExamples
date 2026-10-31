# Comparing and sorting strings.
puts "apple" <=> "banana"
puts "pear" <=> "pear"
puts "Zebra" <=> "apple"
puts "Ruby".casecmp("ruby")
puts "Ruby".casecmp?("RUBY")
puts "abc".eql?("abc")
puts "abc" == "abc"

words = %w[banana Apple cherry apple Banana date]
puts words.sort.inspect
puts words.sort_by(&:downcase).inspect
puts words.sort_by { |w| [w.downcase, w] }.inspect
puts words.uniq { |w| w.downcase }.inspect
puts words.min_by(&:length)
puts words.max
puts words.sort { |a, b| b.length <=> a.length }.first
