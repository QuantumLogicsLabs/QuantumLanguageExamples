# Comb sort with a shrinking gap.
def comb_sort(arr)
  a = arr.dup
  gap = a.size
  sorted = false
  rounds = 0
  until sorted
    gap = (gap / 1.3).floor
    if gap <= 1
      gap = 1
      sorted = true
    end
    rounds += 1
    (0...a.size - gap).each do |i|
      if a[i] > a[i + gap]
        a[i], a[i + gap] = a[i + gap], a[i]
        sorted = false
      end
    end
  end
  [a, rounds]
end

[[8, 4, 1, 56, 3, -44, 23, -6, 28, 0], [1, 2, 3], [9, 8, 7, 6, 5, 4, 3, 2, 1]].each do |input|
  out, rounds = comb_sort(input)
  puts "#{out.inspect} in #{rounds} rounds"
end
