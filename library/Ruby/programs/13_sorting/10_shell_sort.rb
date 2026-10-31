# Shell sort with two gap sequences.
def shell_sort(arr, gaps)
  a = arr.dup
  comparisons = 0
  gaps.each do |gap|
    next if gap >= a.size
    (gap...a.size).each do |i|
      temp = a[i]
      j = i
      while j >= gap
        comparisons += 1
        break unless a[j - gap] > temp
        a[j] = a[j - gap]
        j -= gap
      end
      a[j] = temp
    end
  end
  [a, comparisons]
end

data = [35, 33, 42, 10, 14, 19, 27, 44, 26, 31, 2, 50, 8, 17]
shell_gaps = [7, 3, 1]
knuth = [13, 4, 1]
[shell_gaps, knuth, [1]].each do |g|
  sorted, comps = shell_sort(data, g)
  puts "gaps #{g.inspect}: #{sorted.inspect} (#{comps} comparisons)"
end
