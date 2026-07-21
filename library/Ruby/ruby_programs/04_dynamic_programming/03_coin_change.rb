# Coin change: minimum number of coins to make an amount, and the
# (separate) number of distinct ways to make that amount -- two
# related but subtly different DP formulations.
def coin_change_min_coins(coins, amount)
  dp = Array.new(amount + 1, Float::INFINITY)
  dp[0] = 0
  (1..amount).each do |a|
    coins.each do |coin|
      dp[a] = [dp[a], dp[a - coin] + 1].min if coin <= a
    end
  end
  dp[amount] == Float::INFINITY ? -1 : dp[amount]
end

def coin_change_ways(coins, amount)
  dp = Array.new(amount + 1, 0)
  dp[0] = 1
  coins.each do |coin|
    (coin..amount).each do |a|
      dp[a] += dp[a - coin]
    end
  end
  dp[amount]
end

if __FILE__ == $0
  coins = [1, 2, 5]
  amount = 11
  puts "Minimum coins for #{amount}: #{coin_change_min_coins(coins, amount)}"
  puts "Number of ways to make #{amount}: #{coin_change_ways(coins, amount)}"
end
