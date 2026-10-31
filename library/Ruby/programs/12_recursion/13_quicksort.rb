# Recursive quicksort, functional and in place.
def quicksort(arr)
  return arr if arr.size <= 1
  pivot, *rest = arr
  left, right = rest.partition { |x| x < pivot }
  quicksort(left) + [pivot] + quicksort(right)
end

def quicksort!(a, lo = 0, hi = a.size - 1)
  return a if lo >= hi
  pivot = a[hi]
  i = lo
  (lo...hi).each do |j|
    if a[j] <= pivot
      a[i], a[j] = a[j], a[i]
      i += 1
    end
  end
  a[i], a[hi] = a[hi], a[i]
  quicksort!(a, lo, i - 1)
  quicksort!(a, i + 1, hi)
  a
end

data = [33, 10, 55, 71, 29, 3, 18, 42, 10]
puts quicksort(data).inspect
puts quicksort!(data.dup).inspect
puts quicksort(%w[pear apple fig kiwi banana]).inspect
puts quicksort(data) == data.sort
