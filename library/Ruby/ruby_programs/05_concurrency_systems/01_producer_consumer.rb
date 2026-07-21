# Classic Producer-Consumer pattern using Ruby's built-in thread-safe
# Queue, decoupling production speed from consumption speed.
require 'thread'

def producer_consumer_demo
  queue = Queue.new
  num_items = 10

  producer = Thread.new do
    num_items.times do |i|
      sleep(rand * 0.01)
      queue << i
      puts "[producer] produced #{i}"
    end
    queue << :done
  end

  consumer = Thread.new do
    loop do
      item = queue.pop
      break if item == :done
      sleep(rand * 0.01)
      puts "  [consumer] consumed #{item}"
    end
  end

  [producer, consumer].each(&:join)
end

if __FILE__ == $0
  producer_consumer_demo
  puts "Done."
end
