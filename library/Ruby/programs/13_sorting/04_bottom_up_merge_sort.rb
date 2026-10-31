# Iterative bottom-up merge sort.
def merge(left, right)
  out = []
  i = j = 0
  while i < left.size && j < right.size
    if left[i] <= right[j]
      out << left[i]
      i += 1
    else
      out << right[j]
      j += 1
    end
  end
  out.concat(left[i..]).concat(right[j..])
end

def merge_sort(arr)
  a = arr.dup
  width = 1
  while width < a.size
    a = a.each_slice(2 * width).flat_map { |chunk| merge(chunk[0, width], chunk[width..] || []) }
    puts "width #{width}: #{a.inspect}"
    width *= 2
  end
  a
end

puts merge_sort([38, 27, 43, 3, 9, 82, 10, 1]).inspect
puts merge_sort([5, 4, 3, 2, 1, 0]).inspect
