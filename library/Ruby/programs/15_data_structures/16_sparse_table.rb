# A sparse table answering range-minimum queries in O(1).
class SparseTable
  def initialize(a)
    @log = Array.new(a.size + 1, 0)
    (2..a.size).each { |i| @log[i] = @log[i / 2] + 1 }
    @table = [a.dup]
    j = 1
    while (1 << j) <= a.size
      prev = @table[j - 1]
      @table << (0..a.size - (1 << j)).map { |i| [prev[i], prev[i + (1 << (j - 1))]].min }
      j += 1
    end
  end

  def min(l, r)
    k = @log[r - l + 1]
    [@table[k][l], @table[k][r - (1 << k) + 1]].min
  end
end

data = [7, 2, 3, 0, 5, 10, 3, 12, 18, 1]
st = SparseTable.new(data)
[[0, 2], [1, 5], [4, 7], [7, 9], [3, 3], [0, 9]].each do |l, r|
  puts "min[#{l}..#{r}] = #{st.min(l, r)} (check #{data[l..r].min})"
end
