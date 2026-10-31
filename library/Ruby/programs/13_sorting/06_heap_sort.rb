# Heap sort with an explicit sift-down.
def sift_down(a, start, finish)
  root = start
  while 2 * root + 1 <= finish
    child = 2 * root + 1
    child += 1 if child + 1 <= finish && a[child] < a[child + 1]
    break unless a[root] < a[child]
    a[root], a[child] = a[child], a[root]
    root = child
  end
end

def heap_sort(arr)
  a = arr.dup
  ((a.size - 2) / 2).downto(0) { |s| sift_down(a, s, a.size - 1) }
  puts "heap: #{a.inspect}"
  (a.size - 1).downto(1) do |finish|
    a[0], a[finish] = a[finish], a[0]
    sift_down(a, 0, finish - 1)
  end
  a
end

puts heap_sort([12, 11, 13, 5, 6, 7]).inspect
puts heap_sort([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]).inspect
