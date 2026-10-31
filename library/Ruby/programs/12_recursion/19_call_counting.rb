# Plain versus memoized recursion, measured by call counts.
class Counter
  attr_reader :calls
  def initialize = @calls = 0
  def fib(n)
    @calls += 1
    n < 2 ? n : fib(n - 1) + fib(n - 2)
  end
end

class MemoCounter < Counter
  def initialize
    super
    @memo = {}
  end

  def fib(n) = @memo.fetch(n) { @memo[n] = super }
end

[10, 20, 25].each do |n|
  plain = Counter.new
  memo = MemoCounter.new
  puts "fib(#{n}) = #{plain.fib(n)}: plain #{plain.calls} calls, memoized #{memo.fib(n) && memo.calls} calls"
end
