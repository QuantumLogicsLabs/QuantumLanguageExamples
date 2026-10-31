# Mean, median, mode, range and standard deviation.
data = [12, 7, 3, 14, 7, 9, 21, 7, 14, 10]

mean = data.sum.to_f / data.size
sorted = data.sort
mid = data.size / 2
median = data.size.even? ? (sorted[mid - 1] + sorted[mid]) / 2.0 : sorted[mid]
mode = data.tally.max_by { |_, c| c }.first
variance = data.sum { |x| (x - mean)**2 } / data.size
stddev = Math.sqrt(variance)

puts "Data:     #{data.inspect}"
puts "Sorted:   #{sorted.inspect}"
puts "Mean:     #{mean}"
puts "Median:   #{median}"
puts "Mode:     #{mode}"
puts "Range:    #{data.max - data.min} (#{data.minmax.join('..')})"
puts "Std dev:  #{stddev.round(4)}"
above = data.select { |x| x > mean }
puts "Above mean: #{above.inspect}"
