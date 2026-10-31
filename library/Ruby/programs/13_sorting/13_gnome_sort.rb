# Gnome sort: a garden gnome sorting flower pots.
def gnome_sort(arr)
  a = arr.dup
  i = 0
  steps = 0
  while i < a.size
    steps += 1
    if i.zero? || a[i - 1] <= a[i]
      i += 1
    else
      a[i - 1], a[i] = a[i], a[i - 1]
      i -= 1
    end
  end
  [a, steps]
end

[[34, 2, 10, -9], [1, 2, 3, 4], [4, 3, 2, 1], %w[c a b]].each do |input|
  out, steps = gnome_sort(input)
  puts "#{input.inspect} -> #{out.inspect} (#{steps} steps)"
end
