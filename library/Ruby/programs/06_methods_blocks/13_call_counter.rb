# Wraps methods to count calls, using blocks and define_method.
module Counted
  def self.call_counts = @call_counts ||= Hash.new(0)

  def count_calls(*names)
    names.each do |name|
      original = instance_method(name)
      define_method(name) do |*args, &block|
        Counted.call_counts["#{self.class}##{name}"] += 1
        original.bind(self).call(*args, &block)
      end
    end
  end
end

class Calculator
  extend Counted
  def add(a, b) = a + b
  def mul(a, b) = a * b
  def square(x) = mul(x, x)
  count_calls :add, :mul, :square
end

calc = Calculator.new
puts calc.add(2, 3)
puts calc.square(9)
puts (1..4).map { |i| calc.mul(i, i) }.inspect
Counted.call_counts.sort.each { |name, n| puts "#{name}: #{n}" }
