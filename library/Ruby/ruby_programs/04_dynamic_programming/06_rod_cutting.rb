# Rod cutting: given the sale price for each length of rod piece,
# find the cut lengths that maximize total revenue, via bottom-up DP.
def rod_cutting(prices, length)
  dp = Array.new(length + 1, 0)
  cuts = Array.new(length + 1, 0)

  (1..length).each do |len|
    best = -Float::INFINITY
    (1..len).each do |cut|
      price = prices[cut - 1] || -Float::INFINITY
      if price + dp[len - cut] > best
        best = price + dp[len - cut]
        cuts[len] = cut
      end
    end
    dp[len] = best
  end

  pieces = []
  remaining = length
  while remaining > 0
    pieces << cuts[remaining]
    remaining -= cuts[remaining]
  end

  [dp[length], pieces]
end

if __FILE__ == $0
  prices = [1, 5, 8, 9, 10, 17, 17, 20] # price for length 1..8
  rod_length = 8
  max_revenue, pieces = rod_cutting(prices, rod_length)
  puts "Max revenue for rod of length #{rod_length}: #{max_revenue}"
  puts "Optimal cuts: #{pieces}"
end
