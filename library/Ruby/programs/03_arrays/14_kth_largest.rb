# Second largest, k-th largest and top-k elements.
values = [42, 17, 99, 8, 99, 63, 25, 71]

def second_largest(arr)
  arr.uniq.sort[-2]
end

def kth_largest(arr, k)
  arr.sort.reverse[k - 1]
end

puts "Values: #{values.inspect}"
puts "Largest: #{values.max}"
puts "Second largest distinct: #{second_largest(values)}"
(1..4).each { |k| puts "#{k}-th largest: #{kth_largest(values, k)}" }
puts "Top 3: #{values.max(3).inspect}"
puts "Bottom 3: #{values.min(3).inspect}"
puts "Max by last digit: #{values.max_by { |v| v % 10 }}"
