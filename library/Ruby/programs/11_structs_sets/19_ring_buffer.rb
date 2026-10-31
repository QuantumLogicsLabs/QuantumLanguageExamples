# A fixed-size ring buffer that overwrites the oldest entries.
class RingBuffer
  include Enumerable

  def initialize(capacity)
    @buf = Array.new(capacity)
    @start = 0
    @count = 0
  end

  def <<(item)
    idx = (@start + @count) % @buf.size
    @buf[idx] = item
    if @count < @buf.size
      @count += 1
    else
      @start = (@start + 1) % @buf.size
    end
    self
  end

  def each
    @count.times { |i| yield @buf[(@start + i) % @buf.size] }
  end

  def full? = @count == @buf.size
end

rb = RingBuffer.new(4)
(1..3).each { |i| rb << i }
puts rb.to_a.inspect, rb.full?
(4..9).each { |i| rb << i }
puts rb.to_a.inspect, rb.full?
puts rb.sum
puts rb.map { |x| x * 10 }.inspect

latency = RingBuffer.new(3)
[120, 80, 95, 300, 110].each do |ms|
  latency << ms
  puts "last #{latency.count}: avg #{(latency.sum.to_f / latency.count).round(1)}"
end
