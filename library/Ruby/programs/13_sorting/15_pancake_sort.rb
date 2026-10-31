# Pancake sort: only prefix reversals allowed.
def flip(a, k) = a[0..k].reverse + a[k + 1..]

def pancake_sort(arr)
  a = arr.dup
  flips = []
  (a.size - 1).downto(1) do |size|
    max_i = (0..size).max_by { |i| a[i] }
    next if max_i == size
    unless max_i.zero?
      a = flip(a, max_i)
      flips << max_i + 1
    end
    a = flip(a, size)
    flips << size + 1
  end
  [a, flips]
end

[[3, 2, 4, 1], [1, 5, 4, 3, 2], [1, 2, 3]].each do |stack|
  out, flips = pancake_sort(stack)
  puts "#{stack.inspect} -> #{out.inspect} with flips #{flips.inspect}"
end
