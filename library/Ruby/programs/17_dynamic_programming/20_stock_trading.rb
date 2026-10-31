# Best profit from stock trades with at most k transactions.
def max_profit(prices, k)
  return 0 if prices.empty?
  buy = Array.new(k + 1, -Float::INFINITY)
  sell = Array.new(k + 1, 0)
  prices.each do |p|
    (1..k).each do |t|
      buy[t] = [buy[t], sell[t - 1] - p].max
      sell[t] = [sell[t], buy[t] + p].max
    end
  end
  sell[k]
end

def unlimited(prices) = prices.each_cons(2).sum { |a, b| [b - a, 0].max }

def with_cooldown(prices)
  hold, sold, rest = -Float::INFINITY, 0, 0
  prices.each { |p| hold, sold, rest = [hold, rest - p].max, hold + p, [rest, sold].max }
  [sold, rest].max
end

series = [3, 3, 5, 0, 0, 3, 1, 4]
(1..3).each { |k| puts "k=#{k}: #{max_profit(series, k)}" }
puts "unlimited: #{unlimited(series)}"
puts "with cooldown: #{with_cooldown([1, 2, 3, 0, 2])}"
puts "falling market: #{max_profit([7, 6, 4, 3, 1], 2)}"
