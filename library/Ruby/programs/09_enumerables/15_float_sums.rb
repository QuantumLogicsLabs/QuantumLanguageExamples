# Floating point totals: sum versus naive addition.
values = [0.1] * 10
naive = values.reduce(:+)
puts naive
puts values.sum
puts naive == 1.0
puts values.sum == 1.0

small = [1e20, 1.0, -1e20]
puts small.reduce(:+)
puts small.sum

prices = [19.99, 5.01, 0.1, 0.2, 74.7]
puts prices.sum
puts prices.sum.round(2)
puts prices.reduce(0) { |a, b| a + b }.round(2)
puts (prices.sum * 100).round / 100.0
puts [1, 2, 3].sum / 2
puts [1, 2, 3].sum / 2.0
puts [1.5, 2].sum.class
puts [1, 2].sum(0.0).class
