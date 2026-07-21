# Egg dropping puzzle: with a given number of eggs and floors, find
# the minimum number of trials needed in the worst case to find the
# critical floor, via interval DP.
def egg_drop(eggs, floors)
  dp = Array.new(eggs + 1) { Array.new(floors + 1, 0) }

  (1..floors).each { |j| dp[1][j] = j } # 1 egg: linear search

  (2..eggs).each do |i|
    (1..floors).each do |j|
      dp[i][j] = Float::INFINITY
      (1..j).each do |x|
        # worst case: egg breaks (check floors below x) vs survives (check floors above x)
        worst = 1 + [dp[i - 1][x - 1], dp[i][j - x]].max
        dp[i][j] = [dp[i][j], worst].min
      end
    end
  end

  dp[eggs][floors]
end

if __FILE__ == $0
  [[1, 10], [2, 10], [2, 100], [3, 14]].each do |eggs, floors|
    puts "eggs=#{eggs}, floors=#{floors} => min trials in worst case: #{egg_drop(eggs, floors)}"
  end
end
