# Cocktail shaker sort: bubbling in both directions.
def cocktail_sort(arr)
  a = arr.dup
  lo, hi = 0, a.size - 1
  swapped = true
  while swapped
    swapped = false
    (lo...hi).each do |i|
      next unless a[i] > a[i + 1]
      a[i], a[i + 1] = a[i + 1], a[i]
      swapped = true
    end
    hi -= 1
    (hi - 1).downto(lo) do |i|
      next unless a[i] > a[i + 1]
      a[i], a[i + 1] = a[i + 1], a[i]
      swapped = true
    end
    lo += 1
    puts "  #{a.inspect}"
  end
  a
end

puts cocktail_sort([5, 1, 4, 2, 8, 0, 2]).inspect
puts cocktail_sort([2, 3, 4, 5, 1]).inspect
