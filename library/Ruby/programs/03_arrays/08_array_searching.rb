# Finding elements and positions.
scores = [55, 72, 89, 72, 94, 61, 89]

puts scores.index(72)
puts scores.rindex(72)
puts scores.find_index { |s| s > 80 }
puts scores.find { |s| s > 90 }
puts scores.detect { |s| s > 100 }.inspect
puts scores.include?(61)
puts scores.each_index.select { |i| scores[i] == 89 }.inspect
puts scores.any? { |s| s < 60 }
puts scores.all? { |s| s > 50 }
puts scores.none? { |s| s == 0 }
puts scores.one? { |s| s == 94 }

sorted = scores.sort
puts sorted.inspect
puts sorted.bsearch { |s| s >= 70 }
puts sorted.bsearch_index { |s| s >= 90 }
