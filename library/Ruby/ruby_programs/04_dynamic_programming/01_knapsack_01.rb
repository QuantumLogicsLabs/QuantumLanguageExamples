# 0/1 Knapsack: choose a subset of items (each usable at most once)
# to maximize value under a weight capacity, via bottom-up DP,
# with reconstruction of the chosen items.
def knapsack_01(weights, values, capacity)
  n = weights.length
  dp = Array.new(n + 1) { Array.new(capacity + 1, 0) }

  (1..n).each do |i|
    (0..capacity).each do |w|
      dp[i][w] = dp[i - 1][w]
      if weights[i - 1] <= w
        dp[i][w] = [dp[i][w], dp[i - 1][w - weights[i - 1]] + values[i - 1]].max
      end
    end
  end

  w = capacity
  chosen = []
  n.downto(1) do |i|
    if dp[i][w] != dp[i - 1][w]
      chosen << i - 1
      w -= weights[i - 1]
    end
  end

  [dp[n][capacity], chosen.reverse]
end

if __FILE__ == $0
  weights = [1, 3, 4, 5]
  values  = [1, 4, 5, 7]
  capacity = 7
  max_value, items = knapsack_01(weights, values, capacity)
  puts "Max value: #{max_value}"
  puts "Items chosen (indices): #{items}"
end
