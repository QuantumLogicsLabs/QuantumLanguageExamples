# Searching a sorted array that has been rotated.
def find_rotation(a)
  lo, hi = 0, a.size - 1
  while lo < hi
    mid = (lo + hi) / 2
    a[mid] > a[hi] ? lo = mid + 1 : hi = mid
  end
  lo
end

def search_rotated(a, target)
  lo, hi = 0, a.size - 1
  while lo <= hi
    mid = (lo + hi) / 2
    return mid if a[mid] == target
    if a[lo] <= a[mid]
      target >= a[lo] && target < a[mid] ? hi = mid - 1 : lo = mid + 1
    else
      target > a[mid] && target <= a[hi] ? lo = mid + 1 : hi = mid - 1
    end
  end
  nil
end

rotated = [15, 18, 22, 3, 6, 9, 11]
puts "Rotation point: #{find_rotation(rotated)} (min #{rotated[find_rotation(rotated)]})"
[6, 22, 15, 11, 7].each { |t| puts "#{t}: #{search_rotated(rotated, t).inspect}" }
puts find_rotation([1, 2, 3, 4])
