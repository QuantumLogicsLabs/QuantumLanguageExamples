# An elevator serving requests with a simple SCAN strategy.
class Elevator
  attr_reader :log

  def initialize(floor = 0)
    @floor = floor
    @direction = :up
    @log = []
  end

  def run(requests)
    pending = requests.uniq
    moves = 0
    until pending.empty?
      ahead = pending.select { |f| @direction == :up ? f >= @floor : f <= @floor }
      if ahead.empty?
        @direction = @direction == :up ? :down : :up
        @log << "reverse to #{@direction}"
        next
      end
      target = @direction == :up ? ahead.min : ahead.max
      moves += (target - @floor).abs
      @floor = target
      pending.delete(target)
      @log << "stop at #{target}"
    end
    moves
  end
end

e = Elevator.new(4)
moves = e.run([7, 2, 9, 4, 1, 6, 2])
puts e.log
puts "floors travelled: #{moves}"
fcfs = [4, 7, 2, 9, 4, 1, 6, 2].each_cons(2).sum { |a, b| (a - b).abs }
puts "first-come-first-served would travel: #{fcfs}"
