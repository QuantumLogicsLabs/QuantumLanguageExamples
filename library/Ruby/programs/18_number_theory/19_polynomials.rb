# Polynomial arithmetic with coefficient arrays.
class Poly
  attr_reader :c

  def initialize(coeffs) = @c = trim(coeffs)
  def degree = c.size - 1
  def +(o) = Poly.new(Array.new([c.size, o.c.size].max) { |i| c.fetch(i, 0) + o.c.fetch(i, 0) })
  def -(o) = self + Poly.new(o.c.map(&:-@))
  def *(o) = Poly.new(Array.new(c.size + o.c.size - 1, 0).tap { |out| c.each_with_index { |a, i| o.c.each_with_index { |b, j| out[i + j] += a * b } } })
  def call(x) = c.reverse.reduce(0) { |acc, k| acc * x + k }
  def derivative = Poly.new(c.each_with_index.drop(1).map { |k, i| k * i })

  def to_s
    terms = c.each_with_index.reverse_each.reject { |k, _| k.zero? }.map do |k, i|
      coef = k.abs == 1 && i.positive? ? "" : k.abs.to_s
      var = i.zero? ? "" : i == 1 ? "x" : "x^#{i}"
      [k.negative? ? "-" : "+", coef + var]
    end
    return "0" if terms.empty?
    s = terms.map { |sign, t| "#{sign} #{t}" }.join(" ")
    s.sub(/\A\+ /, "").sub(/\A- /, "-")
  end

  private

  def trim(a)
    a = a.dup
    a.pop while a.size > 1 && a.last.zero?
    a
  end
end

p1 = Poly.new([1, -3, 0, 2])
p2 = Poly.new([-1, 1])
puts p1, p2
puts p1 + p2, p1 - p2, p1 * p2
puts p1.derivative
puts (p2 * p2 * p2)
puts (-2..2).map { |x| p1.(x) }.inspect
puts (p1 - p1)
