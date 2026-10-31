# A FIFO queue built from two stacks.
class StackQueue
  def initialize
    @inbox = []
    @outbox = []
    @transfers = 0
  end

  attr_reader :transfers

  def enqueue(x)
    @inbox.push(x)
    self
  end

  def dequeue
    if @outbox.empty?
      @outbox.push(@inbox.pop) until @inbox.empty?
      @transfers += 1
    end
    @outbox.pop
  end

  def size = @inbox.size + @outbox.size
  def empty? = size.zero?
end

q = StackQueue.new
q.enqueue(1).enqueue(2).enqueue(3)
puts q.dequeue
q.enqueue(4)
out = []
out << q.dequeue until q.empty?
puts out.inspect
puts q.dequeue.inspect
puts "transfers: #{q.transfers}"
