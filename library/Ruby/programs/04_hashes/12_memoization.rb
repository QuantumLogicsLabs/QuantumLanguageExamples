# Memoized recursion with a hash.
def fib(n, memo = {})
  return n if n < 2
  memo[n] ||= fib(n - 1, memo) + fib(n - 2, memo)
end

FIB = Hash.new { |h, n| h[n] = n < 2 ? n : h[n - 1] + h[n - 2] }

puts (0..15).map { |n| fib(n) }.inspect
puts fib(90)
puts FIB[100]
puts FIB.size

calls = Hash.new(0)
collatz = Hash.new do |h, n|
  calls[:computed] += 1
  h[n] = n == 1 ? 1 : 1 + h[n.even? ? n / 2 : 3 * n + 1]
end
longest = (1..3000).max_by { |n| collatz[n] }
puts "Longest Collatz chain below 3000 starts at #{longest} (#{collatz[longest]} terms)"
puts "Values computed: #{calls[:computed]}"
