# transform_values, transform_keys, filter_map and to_h.
prices = { apple: 0.5, bread: 2.25, cheese: 7.0, milk: 1.1 }

puts prices.transform_values { |p| (p * 1.2).round(2) }.inspect
puts prices.transform_keys(&:to_s).inspect
puts prices.transform_keys { |k| k.to_s.upcase.to_sym }.inspect
puts prices.select { |_, p| p > 1 }.inspect
puts prices.reject { |_, p| p > 1 }.inspect
puts prices.filter_map { |item, p| item if p < 2 }.inspect
puts prices.to_h { |k, v| [v, k] }.inspect
puts prices.sum { |_, p| p }
puts prices.min_by(2) { |_, p| p }.to_h.inspect
puts prices.partition { |_, p| p < 1.5 }.map(&:to_h).inspect
