# Dutch national flag partitioning and three-way quicksort.
def dutch_flag(a, pivot)
  lo, mid, hi = 0, 0, a.size - 1
  while mid <= hi
    if a[mid] < pivot
      a[lo], a[mid] = a[mid], a[lo]
      lo += 1
      mid += 1
    elsif a[mid] > pivot
      a[mid], a[hi] = a[hi], a[mid]
      hi -= 1
    else
      mid += 1
    end
  end
  [lo, hi]
end

def quicksort3(a, lo = 0, hi = a.size - 1)
  return a if lo >= hi
  pivot = a[lo]
  sub = a[lo..hi]
  l, h = dutch_flag(sub, pivot)
  a[lo..hi] = sub
  quicksort3(a, lo, lo + l - 1)
  quicksort3(a, lo + h + 1, hi)
  a
end

colors = [2, 0, 2, 1, 1, 0, 2, 0, 1]
dutch_flag(colors, 1)
puts colors.inspect
puts quicksort3([4, 9, 4, 4, 1, 9, 4, 4, 9, 4, 4, 1, 4]).inspect
puts quicksort3([3, 6, 8, 10, 1, 2, 1]).inspect
