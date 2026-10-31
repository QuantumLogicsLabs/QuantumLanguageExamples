# Counting the ways to make change, recursively with memoization.
def ways(amount, coins, memo = {})
  return 1 if amount.zero?
  return 0 if amount.negative? || coins.empty?
  key = [amount, coins.size]
  memo[key] ||= ways(amount - coins.first, coins, memo) + ways(amount, coins.drop(1), memo)
end

def list_ways(amount, coins)
  return [[]] if amount.zero?
  return [] if amount.negative? || coins.empty?
  list_ways(amount - coins.first, coins).map { |w| [coins.first] + w } + list_ways(amount, coins.drop(1))
end

us = [50, 25, 10, 5, 1]
[10, 25, 100].each { |a| puts "#{a} cents: #{ways(a, us)} ways" }
puts "200 pence with UK coins: #{ways(200, [200, 100, 50, 20, 10, 5, 2, 1])}"
list_ways(12, [10, 5, 1]).each { |w| puts w.tally.map { |c, n| "#{n}x#{c}" }.join(" + ") }
