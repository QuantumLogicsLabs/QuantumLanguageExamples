# Bubble sort with early exit and a swap count.
def bubble_sort(arr)
  a = arr.dup
  swaps = 0
  passes = 0
  loop do
    swapped = false
    passes += 1
    (0...a.size - passes).each do |i|
      next unless a[i] > a[i + 1]
      a[i], a[i + 1] = a[i + 1], a[i]
      swaps += 1
      swapped = true
    end
    break unless swapped
  end
  [a, swaps, passes]
end

[[5, 1, 4, 2, 8], [1, 2, 3, 4, 5], [9, 7, 5, 3, 1], [3, 3, 1, 2]].each do |input|
  sorted, swaps, passes = bubble_sort(input)
  puts "#{input.inspect} -> #{sorted.inspect} (#{swaps} swaps, #{passes} passes)"
end
