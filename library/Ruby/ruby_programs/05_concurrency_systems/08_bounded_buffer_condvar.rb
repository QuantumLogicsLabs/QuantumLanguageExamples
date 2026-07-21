# A bounded (fixed-capacity) buffer implemented with a Mutex and two
# ConditionVariables -- one to block producers when full, one to
# block consumers when empty. The textbook building block behind
# most thread-safe queue implementations.
require 'thread'

class BoundedBuffer
  def initialize(capacity)
    @capacity = capacity
    @buffer = []
    @mutex = Mutex.new
    @not_full = ConditionVariable.new
    @not_empty = ConditionVariable.new
  end

  def put(item)
    @mutex.synchronize do
      @not_full.wait(@mutex) while @buffer.size >= @capacity
      @buffer << item
      @not_empty.signal
    end
  end

  def take
    @mutex.synchronize do
      @not_empty.wait(@mutex) while @buffer.empty?
      item = @buffer.shift
      @not_full.signal
      item
    end
  end
end

if __FILE__ == $0
  buffer = BoundedBuffer.new(3)
  produced = []
  consumed = []

  producer = Thread.new do
    10.times do |i|
      buffer.put(i)
      produced << i
    end
  end

  consumer = Thread.new do
    10.times { consumed << buffer.take }
  end

  [producer, consumer].each(&:join)
  puts "Produced: #{produced}"
  puts "Consumed: #{consumed}"
  puts "Bounded buffer correctly throttled production to capacity 3."
end
