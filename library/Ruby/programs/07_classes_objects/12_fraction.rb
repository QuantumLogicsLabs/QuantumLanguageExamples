# A Fraction class with normalised arithmetic.
class Fraction
  include Comparable
  attr_reader :num, :den

  def initialize(num, den = 1)
    raise ZeroDivisionError, "denominator is zero" if den.zero?
    g = num.gcd(den)
    sign = den.negative? ? -1 : 1
    @num = sign * num / g
    @den = sign * den / g
  end

  def +(o) = Fraction.new(num * o.den + o.num * den, den * o.den)
  def -(o) = Fraction.new(num * o.den - o.num * den, den * o.den)
  def *(o) = Fraction.new(num * o.num, den * o.den)
  def /(o) = Fraction.new(num * o.den, den * o.num)
  def <=>(o) = num * o.den <=> o.num * den
  def to_f = num.to_f / den
  def to_s = den == 1 ? num.to_s : "#{num}/#{den}"
end

a = Fraction.new(1, 2)
b = Fraction.new(3, -4)
puts [a, b, a + b, a - b, a * b, a / b].map(&:to_s).join("  ")
puts Fraction.new(6, 8)
puts [Fraction.new(2, 3), Fraction.new(1, 4), Fraction.new(5, 6)].sort.map(&:to_s).inspect
sum = (1..6).map { |n| Fraction.new(1, n * (n + 1)) }.reduce(:+)
puts "1/2 + 1/6 + ... + 1/42 = #{sum} (#{sum.to_f.round(4)})"
begin
  Fraction.new(1, 0)
rescue ZeroDivisionError => e
  puts "Error: #{e.message}"
end
