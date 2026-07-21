# Three ways to compute Fibonacci numbers -- naive recursion (O(2^n)),
# top-down memoization (O(n)), and bottom-up tabulation (O(n), O(1)
# space) -- benchmarked side by side to make the difference concrete.
require 'benchmark'

def fib_naive(n)
  return n if n <= 1
  fib_naive(n - 1) + fib_naive(n - 2)
end

def fib_memo(n, memo = {})
  return n if n <= 1
  memo[n] ||= fib_memo(n - 1, memo) + fib_memo(n - 2, memo)
end

def fib_tabulation(n)
  return n if n <= 1
  a, b = 0, 1
  (2..n).each { a, b = b, a + b }
  b
end

if __FILE__ == $0
  n = 30
  puts "fib_naive(#{n}) = #{fib_naive(n)}"
  puts "fib_memo(#{n}) = #{fib_memo(n)}"
  puts "fib_tabulation(#{n}) = #{fib_tabulation(n)}"

  Benchmark.bm(15) do |bm|
    bm.report("naive:")      { fib_naive(n) }
    bm.report("memoized:")   { fib_memo(n) }
    bm.report("tabulation:") { fib_tabulation(n) }
  end
end
