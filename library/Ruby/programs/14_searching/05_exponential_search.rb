# Exponential search for unbounded-style lookups.
def binary(arr, target, lo, hi)
  while lo <= hi
    mid = (lo + hi) / 2
    return mid if arr[mid] == target
    arr[mid] < target ? lo = mid + 1 : hi = mid - 1
  end
  nil
end

def exponential_search(arr, target)
  return 0 if arr[0] == target
  bound = 1
  bound *= 2 while bound < arr.size && arr[bound] < target
  puts "  range found: #{bound / 2}..#{[bound, arr.size - 1].min}"
  binary(arr, target, bound / 2, [bound, arr.size - 1].min)
end

data = (1..200).map { |i| i * 3 }
[3, 300, 597, 600, 601].each do |t|
  puts "#{t}:"
  puts "  => #{exponential_search(data, t).inspect}"
end
