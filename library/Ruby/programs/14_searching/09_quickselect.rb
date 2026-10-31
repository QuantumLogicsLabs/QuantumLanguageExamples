# Quickselect for k-th smallest and the median.
def quickselect(arr, k)
  a = arr.dup
  lo, hi = 0, a.size - 1
  loop do
    pivot = a[(lo + hi) / 2]
    i, j = lo, hi
    while i <= j
      i += 1 while a[i] < pivot
      j -= 1 while a[j] > pivot
      next unless i <= j
      a[i], a[j] = a[j], a[i]
      i += 1
      j -= 1
    end
    if k <= j then hi = j
    elsif k >= i then lo = i
    else return a[k]
    end
  end
end

data = [7, 10, 4, 3, 20, 15, 4, 8, 1]
(0...data.size).each { |k| print quickselect(data, k), " " }
puts
puts "median: #{quickselect(data, data.size / 2)}"
puts "matches sort: #{(0...data.size).map { |k| quickselect(data, k) } == data.sort}"
