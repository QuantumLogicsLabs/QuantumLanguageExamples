# A minimal thread pool: a fixed number of worker threads pull jobs
# from a shared Queue until a shutdown sentinel tells them to stop.
require 'thread'

class ThreadPool
  def initialize(size)
    @size = size
    @jobs = Queue.new
    @pool = Array.new(size) do
      Thread.new do
        loop do
          job = @jobs.pop
          break if job == :shutdown
          job.call
        end
      end
    end
  end

  def schedule(&block)
    @jobs << block
  end

  def shutdown
    @size.times { @jobs << :shutdown }
    @pool.each(&:join)
  end
end

if __FILE__ == $0
  results = Queue.new
  pool = ThreadPool.new(4)

  10.times do |i|
    pool.schedule do
      sleep(rand * 0.02)
      results << (i * i)
    end
  end

  pool.shutdown
  puts "Results (order may vary): #{Array.new(10) { results.pop }.sort}"
end
