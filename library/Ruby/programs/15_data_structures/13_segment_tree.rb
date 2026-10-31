# A segment tree for range sums with point updates.
class SegmentTree
  def initialize(values)
    @n = values.size
    @tree = Array.new(2 * @n, 0)
    values.each_with_index { |v, i| @tree[@n + i] = v }
    (@n - 1).downto(1) { |i| @tree[i] = @tree[2 * i] + @tree[2 * i + 1] }
  end

  def update(i, value)
    i += @n
    @tree[i] = value
    while i > 1
      i /= 2
      @tree[i] = @tree[2 * i] + @tree[2 * i + 1]
    end
  end

  def sum(lo, hi)
    total = 0
    lo += @n
    hi += @n + 1
    while lo < hi
      if lo.odd?
        total += @tree[lo]
        lo += 1
      end
      if hi.odd?
        hi -= 1
        total += @tree[hi]
      end
      lo /= 2
      hi /= 2
    end
    total
  end
end

data = [5, 8, 6, 3, 2, 7, 2, 6]
st = SegmentTree.new(data)
[[0, 7], [2, 5], [3, 3], [1, 6]].each { |l, h| puts "sum[#{l}..#{h}] = #{st.sum(l, h)} (check #{data[l..h].sum})" }
st.update(3, 10)
data[3] = 10
puts "after update: sum[2..5] = #{st.sum(2, 5)} (check #{data[2..5].sum})"
