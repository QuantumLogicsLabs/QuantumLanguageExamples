# A min-heap with push, pop and heapify.
class MinHeap
  def initialize(items = [])
    @a = items.dup
    ((@a.size / 2) - 1).downto(0) { |i| down(i) }
  end

  def push(x)
    @a << x
    up(@a.size - 1)
    self
  end

  def pop
    return nil if @a.empty?
    top = @a[0]
    last = @a.pop
    unless @a.empty?
      @a[0] = last
      down(0)
    end
    top
  end

  def peek = @a[0]
  def size = @a.size
  def valid? = (1...@a.size).all? { |i| @a[(i - 1) / 2] <= @a[i] }

  private

  def up(i)
    while i.positive? && @a[(i - 1) / 2] > @a[i]
      p = (i - 1) / 2
      @a[p], @a[i] = @a[i], @a[p]
      i = p
    end
  end

  def down(i)
    loop do
      l, r = 2 * i + 1, 2 * i + 2
      m = i
      m = l if l < @a.size && @a[l] < @a[m]
      m = r if r < @a.size && @a[r] < @a[m]
      break if m == i
      @a[m], @a[i] = @a[i], @a[m]
      i = m
    end
  end
end

h = MinHeap.new([9, 4, 7, 1, 8, 2])
puts h.valid?, h.peek
h.push(0).push(5)
out = []
out << h.pop while h.size.positive?
puts out.inspect

k_largest = [12, 3, 25, 8, 19, 30, 1, 22].each_with_object(MinHeap.new) do |x, heap|
  heap.push(x)
  heap.pop if heap.size > 3
end
puts "3 largest: #{Array.new(3) { k_largest.pop }.inspect}"
