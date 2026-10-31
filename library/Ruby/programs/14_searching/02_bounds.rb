# Lower and upper bounds with binary search.
def lower_bound(a, x)
  lo, hi = 0, a.size
  while lo < hi
    mid = (lo + hi) / 2
    a[mid] < x ? lo = mid + 1 : hi = mid
  end
  lo
end

def upper_bound(a, x)
  lo, hi = 0, a.size
  while lo < hi
    mid = (lo + hi) / 2
    a[mid] <= x ? lo = mid + 1 : hi = mid
  end
  lo
end

a = [1, 2, 4, 4, 4, 7, 9, 9, 12]
[4, 9, 5, 0, 13, 1].each do |x|
  lb = lower_bound(a, x)
  ub = upper_bound(a, x)
  puts "#{x.to_s.rjust(2)}: lower #{lb}, upper #{ub}, count #{ub - lb}"
end
puts "Values in [3, 9): #{a[lower_bound(a, 3)...lower_bound(a, 9)].inspect}"
puts a.bsearch_index { |v| v >= 4 }
