# 0/1 knapsack with the chosen items reconstructed.
Item = Struct.new(:name, :weight, :value)
ITEMS = [
  Item.new("tent", 5, 60), Item.new("stove", 3, 50), Item.new("camera", 4, 70),
  Item.new("book", 2, 30), Item.new("food", 6, 90), Item.new("lamp", 1, 15)
].freeze

def knapsack(items, capacity)
  dp = Array.new(items.size + 1) { Array.new(capacity + 1, 0) }
  items.each_with_index do |it, i|
    (0..capacity).each do |w|
      dp[i + 1][w] = dp[i][w]
      dp[i + 1][w] = [dp[i + 1][w], dp[i][w - it.weight] + it.value].max if it.weight <= w
    end
  end
  chosen = []
  w = capacity
  items.size.downto(1) do |i|
    next if dp[i][w] == dp[i - 1][w]
    chosen << items[i - 1]
    w -= items[i - 1].weight
  end
  [dp[items.size][capacity], chosen.reverse]
end

[8, 12, 21].each do |cap|
  value, chosen = knapsack(ITEMS, cap)
  puts "capacity #{cap}: value #{value}, items #{chosen.map(&:name).join(', ')} (weight #{chosen.sum(&:weight)})"
end
