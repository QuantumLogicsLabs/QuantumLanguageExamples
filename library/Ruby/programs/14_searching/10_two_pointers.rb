# Two-pointer techniques on sorted arrays.
def pair_with_sum(a, target)
  i, j = 0, a.size - 1
  while i < j
    s = a[i] + a[j]
    return [a[i], a[j]] if s == target
    s < target ? i += 1 : j -= 1
  end
  nil
end

def count_pairs_below(a, limit)
  i, j = 0, a.size - 1
  count = 0
  while i < j
    if a[i] + a[j] < limit
      count += j - i
      i += 1
    else
      j -= 1
    end
  end
  count
end

def dedupe_sorted(a)
  return a if a.empty?
  w = 1
  (1...a.size).each do |r|
    next if a[r] == a[w - 1]
    a[w] = a[r]
    w += 1
  end
  a[0...w]
end

nums = [1, 2, 3, 4, 6, 8, 11, 15]
[10, 19, 26, 100].each { |t| puts "sum #{t}: #{pair_with_sum(nums, t).inspect}" }
puts "pairs below 9: #{count_pairs_below(nums, 9)}"
puts dedupe_sorted([1, 1, 2, 3, 3, 3, 4, 5, 5]).inspect
