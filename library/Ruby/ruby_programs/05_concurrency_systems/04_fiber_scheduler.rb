# Cooperative multitasking with Fibers: each fiber voluntarily yields
# control, and a simple round-robin scheduler resumes them in turn --
# unlike Threads, there's no preemption, so no locks are needed here.
class FiberScheduler
  def initialize
    @fibers = []
  end

  def register(&block)
    @fibers << Fiber.new(&block)
    self
  end

  def run
    until @fibers.empty?
      @fibers.reject! do |fiber|
        if fiber.alive?
          fiber.resume
          false
        else
          true
        end
      end
    end
  end
end

if __FILE__ == $0
  scheduler = FiberScheduler.new

  scheduler.register do
    3.times do |i|
      puts "Task A step #{i}"
      Fiber.yield
    end
  end

  scheduler.register do
    3.times do |i|
      puts "Task B step #{i}"
      Fiber.yield
    end
  end

  scheduler.run
  puts "All fibers complete."
end
