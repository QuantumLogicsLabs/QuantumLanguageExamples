# Fixed-capacity circular (ring) buffer queue with O(1) enqueue/dequeue.
class CircularQueue
  def initialize(capacity)
    @capacity = capacity
    @data = Array.new(capacity)
    @head = 0
    @tail = 0
    @count = 0
  end

  def full?
    @count == @capacity
  end

  def empty?
    @count.zero?
  end

  def enqueue(value)
    raise "Queue full" if full?
    @data[@tail] = value
    @tail = (@tail + 1) % @capacity
    @count += 1
    self
  end

  def dequeue
    raise "Queue empty" if empty?
    value = @data[@head]
    @head = (@head + 1) % @capacity
    @count -= 1
    value
  end

  def to_a
    (0...@count).map { |i| @data[(@head + i) % @capacity] }
  end
end

if __FILE__ == $0
  q = CircularQueue.new(5)
  [1, 2, 3, 4, 5].each { |v| q.enqueue(v) }
  puts "Queue: #{q.to_a}"
  puts "Dequeued: #{q.dequeue}, #{q.dequeue}"
  q.enqueue(6).enqueue(7)
  puts "Queue after wraparound: #{q.to_a}"
end
