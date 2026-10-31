# Detecting increasing and decreasing runs.
series = [1, 3, 5, 4, 2, 2, 6, 7, 9, 8, 1]

runs = series.slice_when { |a, b| b <= a }.to_a
puts "Increasing runs: #{runs.inspect}"
longest = runs.max_by(&:size)
puts "Longest increasing run: #{longest.inspect}"

direction = series.each_cons(2).map { |a, b| b <=> a }
puts direction.map { |d| { 1 => "/", -1 => "\\", 0 => "-" }[d] }.join
turns = direction.each_cons(2).count { |a, b| a != b && a != 0 && b != 0 }
puts "Direction changes: #{turns}"
peaks = series.each_cons(3).each_with_index.select { |(a, b, c), _| b > a && b > c }.map { |_, i| i + 1 }
puts "Peaks at indexes: #{peaks.inspect}"
puts "Strictly increasing? #{series.each_cons(2).all? { |a, b| b > a }}"
puts "Sorted copy is non-decreasing? #{series.sort.each_cons(2).all? { |a, b| b >= a }}"
