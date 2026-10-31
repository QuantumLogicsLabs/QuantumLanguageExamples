# Recursive binary search, with first and last occurrences.
def bsearch(arr, target, lo = 0, hi = arr.size - 1)
  return nil if lo > hi
  mid = (lo + hi) / 2
  case arr[mid] <=> target
  when 0 then mid
  when 1 then bsearch(arr, target, lo, mid - 1)
  else bsearch(arr, target, mid + 1, hi)
  end
end

def first_index(arr, target, lo = 0, hi = arr.size - 1, found = nil)
  return found if lo > hi
  mid = (lo + hi) / 2
  if arr[mid] >= target
    first_index(arr, target, lo, mid - 1, arr[mid] == target ? mid : found)
  else
    first_index(arr, target, mid + 1, hi, found)
  end
end

data = [1, 3, 3, 3, 5, 8, 13, 13, 21, 34]
[3, 13, 21, 4, 1, 34, 50].each do |t|
  puts "#{t}: index #{bsearch(data, t).inspect}, first #{first_index(data, t).inspect}"
end
