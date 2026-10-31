# Exact fractions with Rational.
a = Rational(1, 3)
b = Rational(1, 6)
puts a + b
puts a - b
puts a * b
puts a / b
puts (a + b).to_f
puts 3/4r
puts 0.75.to_r
puts 0.1.rationalize(Rational(1, 100))
puts Rational(6, 8)
puts Rational(6, 8).numerator
puts Rational(6, 8).denominator

harmonic = (1..10).sum { |n| Rational(1, n) }
puts "H(10) = #{harmonic} = #{harmonic.to_f.round(6)}"
egyptian = [2, 3, 7, 42].sum { |d| Rational(1, d) }
puts "1/2 + 1/3 + 1/7 + 1/42 = #{egyptian}"
