# A memoize class macro built with prepend and define_method.
module Memoize
  def memoize(name)
    cache_module = Module.new do
      define_method(name) do |*args|
        @__memo ||= {}
        @__memo.fetch([name, args]) { @__memo[[name, args]] = super(*args) }
      end
    end
    prepend cache_module
  end
end

class Solver
  extend Memoize
  attr_reader :work

  def initialize = @work = 0

  def slow_square(n)
    @work += 1
    n * n
  end
  memoize :slow_square

  def paths(r, c)
    @work += 1
    r.zero? || c.zero? ? 1 : paths(r - 1, c) + paths(r, c - 1)
  end
  memoize :paths
end

s = Solver.new
puts [4, 4, 5, 4].map { |n| s.slow_square(n) }.inspect
puts "work: #{s.work}"
puts s.paths(12, 12)
puts "work after paths: #{s.work}"
