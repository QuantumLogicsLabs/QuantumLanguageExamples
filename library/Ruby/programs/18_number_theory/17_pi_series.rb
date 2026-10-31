# Approximating pi with several series.
def leibniz(terms) = 4 * (0...terms).sum { |k| (-1.0)**k / (2 * k + 1) }
def nilakantha(terms) = 3 + (1..terms).sum { |k| (-1.0)**(k + 1) * 4 / ((2 * k) * (2 * k + 1) * (2 * k + 2)) }
def wallis(terms) = 2 * (1..terms).reduce(1.0) { |acc, k| acc * (4.0 * k * k) / (4.0 * k * k - 1) }
def machin = 4 * (4 * Math.atan(1.0 / 5) - Math.atan(1.0 / 239))

[10, 100, 1000].each do |n|
  puts format("%5d terms: leibniz %.8f  nilakantha %.12f  wallis %.8f", n, leibniz(n), nilakantha(n), wallis(n))
end
puts format("machin:     %.15f", machin)
puts format("Math::PI:   %.15f", Math::PI)
puts "leibniz error after 1000 terms: #{(leibniz(1000) - Math::PI).abs.round(6)}"
