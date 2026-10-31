# Cycle sort: the minimum number of writes.
def cycle_sort(arr)
  a = arr.dup
  writes = 0
  (0...a.size - 1).each do |start|
    item = a[start]
    pos = start + a[start + 1..].count { |x| x < item }
    next if pos == start
    pos += 1 while item == a[pos]
    a[pos], item = item, a[pos]
    writes += 1
    while pos != start
      pos = start + a[start + 1..].count { |x| x < item }
      pos += 1 while item == a[pos]
      a[pos], item = item, a[pos]
      writes += 1
    end
  end
  [a, writes]
end

[[5, 2, 4, 1, 3], [1, 8, 3, 9, 10, 10, 2, 4], [1, 2, 3]].each do |input|
  out, writes = cycle_sort(input)
  puts "#{input.inspect} -> #{out.inspect} (#{writes} writes)"
end
