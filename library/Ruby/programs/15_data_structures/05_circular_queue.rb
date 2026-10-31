# A fixed-capacity circular queue.
class CircularQueue
  def initialize(capacity)
    @data = Array.new(capacity)
    @head = 0
    @count = 0
  end

  def full? = @count == @data.size
  def empty? = @count.zero?

  def enqueue(x)
    return false if full?
    @data[(@head + @count) % @data.size] = x
    @count += 1
    true
  end

  def dequeue
    return nil if empty?
    x = @data[@head]
    @data[@head] = nil
    @head = (@head + 1) % @data.size
    @count -= 1
    x
  end

  def to_a = Array.new(@count) { |i| @data[(@head + i) % @data.size] }
  def raw = @data.inspect
end

q = CircularQueue.new(4)
puts (1..5).map { |i| q.enqueue(i) }.inspect
puts q.raw
puts q.dequeue, q.dequeue
puts q.enqueue(6), q.enqueue(7), q.enqueue(8)
puts q.raw
puts q.to_a.inspect
puts q.dequeue until q.empty?
