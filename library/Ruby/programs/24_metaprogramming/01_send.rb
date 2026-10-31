# Calling methods by name with send and public_send.
class Calculator
  def add(a, b) = a + b
  def sub(a, b) = a - b
  def mul(a, b) = a * b

  private

  def secret = "hidden result"
end

calc = Calculator.new
%w[add sub mul].each { |op| puts "#{op}(6, 3) = #{calc.send(op, 6, 3)}" }
puts calc.public_send(:add, 1, 2)
puts calc.send(:secret)
begin
  calc.public_send(:secret)
rescue NoMethodError
  puts "public_send refuses private methods"
end
puts 5.send(:+, 3)
puts [3, 1, 2].send(:sort).inspect
puts "ruby".send(:upcase)
ops = [[:+, 2], [:*, 10], [:-, 1], [:fdiv, 4]]
puts ops.reduce(5) { |acc, (op, arg)| acc.send(op, arg) }
puts calc.respond_to?(:secret), calc.respond_to?(:secret, true)
