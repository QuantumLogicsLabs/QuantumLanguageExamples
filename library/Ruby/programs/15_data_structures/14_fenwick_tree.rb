# A Fenwick (binary indexed) tree for prefix sums.
class Fenwick
  def initialize(n) = @tree = Array.new(n + 1, 0)

  def add(i, delta)
    i += 1
    while i < @tree.size
      @tree[i] += delta
      i += i & -i
    end
  end

  def prefix(i)
    i += 1
    s = 0
    while i.positive?
      s += @tree[i]
      i -= i & -i
    end
    s
  end

  def range(l, r) = prefix(r) - (l.positive? ? prefix(l - 1) : 0)
end

values = [3, 2, -1, 6, 5, 4, -3, 3, 7, 2, 3]
fw = Fenwick.new(values.size)
values.each_with_index { |v, i| fw.add(i, v) }
puts (0...values.size).map { |i| fw.prefix(i) }.inspect
puts fw.range(3, 7)
fw.add(4, 10)
puts fw.range(3, 7)

inversions = 0
counts = Fenwick.new(10)
[8, 4, 2, 1, 7, 3].each do |x|
  inversions += counts.range(x + 1, 9)
  counts.add(x, 1)
end
puts "inversions: #{inversions}"
