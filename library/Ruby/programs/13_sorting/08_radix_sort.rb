# LSD radix sort, showing each digit pass.
def radix_sort(arr, base = 10)
  a = arr.dup
  max = a.max
  exp = 1
  while max / exp > 0
    buckets = Array.new(base) { [] }
    a.each { |x| buckets[(x / exp) % base] << x }
    a = buckets.flatten
    puts "exp #{exp}: #{a.inspect}"
    exp *= base
  end
  a
end

puts radix_sort([170, 45, 75, 90, 802, 24, 2, 66]).inspect
puts radix_sort([5, 3, 7, 1], 2).inspect
