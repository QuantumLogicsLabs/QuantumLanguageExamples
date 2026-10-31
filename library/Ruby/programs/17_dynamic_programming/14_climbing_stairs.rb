# Counting ways to climb stairs with different step sets.
def ways(n, steps)
  dp = Array.new(n + 1, 0)
  dp[0] = 1
  (1..n).each { |i| dp[i] = steps.sum { |s| s <= i ? dp[i - s] : 0 } }
  dp[n]
end

def min_cost(costs)
  a, b = 0, 0
  costs.each { |c| a, b = b, [a, b].min + c }
  [a, b].min
end

puts (1..12).map { |n| ways(n, [1, 2]) }.inspect
puts (1..12).map { |n| ways(n, [1, 2, 3]) }.inspect
puts ways(30, [1, 3, 5])
puts ways(10, [2, 4])
puts ways(7, [2, 4])
puts "min cost: #{min_cost([10, 15, 20])}, #{min_cost([1, 100, 1, 1, 1, 100, 1, 1, 100, 1])}"
