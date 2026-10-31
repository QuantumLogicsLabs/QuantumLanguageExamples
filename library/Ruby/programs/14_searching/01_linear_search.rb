# Linear search variants with comparison counts.
def linear_search(arr, target)
  arr.each_with_index { |v, i| return [i, i + 1] if v == target }
  [nil, arr.size]
end

def sentinel_search(arr, target)
  a = arr + [target]
  i = 0
  i += 1 until a[i] == target
  i < arr.size ? i : nil
end

def find_all(arr, &pred) = arr.each_index.select { |i| pred.call(arr[i]) }

data = [17, 4, 23, 8, 42, 15, 4, 16]
[42, 4, 99].each do |t|
  idx, comps = linear_search(data, t)
  puts "#{t}: index #{idx.inspect} after #{comps} comparisons, sentinel #{sentinel_search(data, t).inspect}"
end
puts "Even positions: #{find_all(data, &:even?).inspect}"
puts "Last 4 at #{data.rindex(4)}"
puts "First over 20: #{data.find { |x| x > 20 }}"
