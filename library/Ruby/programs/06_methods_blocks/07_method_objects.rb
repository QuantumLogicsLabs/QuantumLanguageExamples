# Methods as objects.
def double(x) = x * 2
def increment(x) = x + 1

m = method(:double)
puts m.call(21)
puts m.arity
puts m.name.inspect
puts [1, 2, 3].map(&method(:double)).inspect
puts [1, 2, 3].map(&method(:increment)).inspect

pipeline = method(:double) >> method(:increment)
puts pipeline.call(5)
reverse = method(:double) << method(:increment)
puts reverse.call(5)

upcase = :upcase.to_proc
puts upcase.call("ruby")
puts %w[a b].map(&:upcase).inspect

class Greeter
  def initialize(greeting) = @greeting = greeting
  def greet(name) = "#{@greeting}, #{name}"
end
hi = Greeter.new("Hi").method(:greet)
puts %w[Ana Ben].map(&hi).inspect
unbound = Greeter.instance_method(:greet)
puts unbound.bind(Greeter.new("Yo")).call("Cy")
