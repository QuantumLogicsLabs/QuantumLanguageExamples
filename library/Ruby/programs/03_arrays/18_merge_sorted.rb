# Merging sorted arrays.
def merge(a, b)
  result = []
  i = j = 0
  while i < a.size && j < b.size
    if a[i] <= b[j]
      result << a[i]
      i += 1
    else
      result << b[j]
      j += 1
    end
  end
  result + a[i..] + b[j..]
end

def merge_all(lists)
  lists.reduce([]) { |acc, l| merge(acc, l) }
end

puts merge([1, 4, 9], [2, 3, 10, 12]).inspect
puts merge([], [1, 2]).inspect
puts merge([5, 6], []).inspect
puts merge_all([[1, 5, 9], [2, 6], [3, 4, 7, 8], [0]]).inspect
puts (merge([1, 3, 5], [2, 4, 6]) == [1, 2, 3, 4, 5, 6])
