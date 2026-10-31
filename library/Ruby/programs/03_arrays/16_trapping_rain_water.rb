# Water trapped between bars, two ways.
def trapped_prefix(heights)
  n = heights.size
  left = Array.new(n, 0)
  right = Array.new(n, 0)
  (0...n).each { |i| left[i] = [heights[i], i.positive? ? left[i - 1] : 0].max }
  (n - 1).downto(0) { |i| right[i] = [heights[i], i < n - 1 ? right[i + 1] : 0].max }
  (0...n).sum { |i| [left[i], right[i]].min - heights[i] }
end

def trapped_two_pointer(h)
  lo, hi = 0, h.size - 1
  left_max = right_max = water = 0
  while lo < hi
    if h[lo] < h[hi]
      h[lo] >= left_max ? left_max = h[lo] : water += left_max - h[lo]
      lo += 1
    else
      h[hi] >= right_max ? right_max = h[hi] : water += right_max - h[hi]
      hi -= 1
    end
  end
  water
end

[[0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1], [4, 2, 0, 3, 2, 5], [1, 2, 3], [5, 0, 5]].each do |h|
  puts "#{h.inspect}: #{trapped_prefix(h)} / #{trapped_two_pointer(h)}"
end
