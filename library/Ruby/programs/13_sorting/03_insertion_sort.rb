# Insertion sort counting element shifts.
def insertion_sort(arr)
  a = arr.dup
  shifts = 0
  (1...a.size).each do |i|
    key = a[i]
    j = i - 1
    while j >= 0 && a[j] > key
      a[j + 1] = a[j]
      j -= 1
      shifts += 1
    end
    a[j + 1] = key
  end
  [a, shifts]
end

[[12, 11, 13, 5, 6], [1, 2, 3], [3, 2, 1], [5, 5, 4, 4]].each do |input|
  sorted, shifts = insertion_sort(input)
  puts "#{input.inspect} -> #{sorted.inspect} (#{shifts} shifts)"
end
words, = insertion_sort(%w[pear apple fig cherry banana])
puts words.inspect
