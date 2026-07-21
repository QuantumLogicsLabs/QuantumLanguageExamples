# Binary heap implemented on an array, parameterized by a comparator
# so it can act as either a min-heap or max-heap. Used to build heapsort.
class BinaryHeap
  def initialize(&comparator)
    @data = []
    @cmp = comparator || ->(a, b) { a <=> b }
  end

  def push(value)
    @data << value
    sift_up(@data.size - 1)
    self
  end

  def pop
    return nil if @data.empty?
    top = @data[0]
    last = @data.pop
    unless @data.empty?
      @data[0] = last
      sift_down(0)
    end
    top
  end

  def peek
    @data[0]
  end

  def empty?
    @data.empty?
  end

  def size
    @data.size
  end

  private

  def sift_up(i)
    while i > 0
      parent = (i - 1) / 2
      break if @cmp.call(@data[i], @data[parent]) >= 0
      @data[i], @data[parent] = @data[parent], @data[i]
      i = parent
    end
  end

  def sift_down(i)
    loop do
      left, right, smallest = 2 * i + 1, 2 * i + 2, i
      smallest = left if left < @data.size && @cmp.call(@data[left], @data[smallest]) < 0
      smallest = right if right < @data.size && @cmp.call(@data[right], @data[smallest]) < 0
      break if smallest == i
      @data[i], @data[smallest] = @data[smallest], @data[i]
      i = smallest
    end
  end
end

def heapsort(array)
  heap = BinaryHeap.new
  array.each { |v| heap.push(v) }
  result = []
  result << heap.pop until heap.empty?
  result
end

if __FILE__ == $0
  min_heap = BinaryHeap.new
  [5, 3, 8, 1, 9, 2].each { |v| min_heap.push(v) }
  puts "Min popped in order: #{Array.new(6) { min_heap.pop }}"

  max_heap = BinaryHeap.new { |a, b| b <=> a }
  [5, 3, 8, 1, 9, 2].each { |v| max_heap.push(v) }
  puts "Max popped in order: #{Array.new(6) { max_heap.pop }}"

  puts "Heapsort: #{heapsort([9, 4, 7, 1, 3, 8, 2])}"
end
