# The core transformations.
nums = (1..12).to_a
puts nums.map { |n| n * n }.inspect
puts nums.select(&:even?).inspect
puts nums.reject(&:even?).inspect
puts nums.filter { |n| n % 3 == 0 }.inspect
puts nums.collect { |n| n.to_s.rjust(2, "0") }.join(" ")
puts nums.map.with_index { |n, i| n * i }.inspect
puts nums.select.with_index { |_, i| i % 4 == 0 }.inspect
words = %w[kiwi apple fig banana cherry date]
puts words.map(&:length).inspect
puts words.reject { |w| w.length < 5 }.inspect
puts words.select { |w| w.include?("a") }.map(&:upcase).inspect
puts words.map { |w| [w, w.length] }.to_h.inspect
puts nums.map { |n| n.even? ? n / 2 : n * 3 + 1 }.inspect
