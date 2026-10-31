# Simple moving averages over a price series.
prices = [10.0, 11.5, 12.25, 11.0, 13.5, 14.0, 13.25, 15.5, 16.0, 15.0]

def moving_average(values, window)
  values.each_cons(window).map { |w| (w.sum / window).round(3) }
end

[3, 5].each do |w|
  puts "SMA(#{w}): #{moving_average(prices, w).inspect}"
end

changes = prices.each_cons(2).map { |a, b| ((b - a) / a * 100).round(2) }
puts "Daily change %: #{changes.inspect}"
best = changes.each_with_index.max_by { |c, _| c }
puts "Best day: day #{best[1] + 2} (+#{best[0]}%)"
gain = prices.each_with_index.to_a.combination(2).map { |(a, i), (b, j)| [b - a, i, j] }.max
puts "Best trade: buy day #{gain[1] + 1}, sell day #{gain[2] + 1}, profit #{gain[0]}"
