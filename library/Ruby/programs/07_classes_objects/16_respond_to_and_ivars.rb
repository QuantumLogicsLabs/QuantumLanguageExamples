# Introspecting objects: instance variables and capabilities.
class Gadget
  def initialize(name, price)
    @name = name
    @price = price
  end

  def describe = "#{@name} at $#{@price}"
end

g = Gadget.new("Lamp", 25)
puts g.instance_variables.inspect
puts g.instance_variable_get(:@name)
g.instance_variable_set(:@price, 30)
puts g.describe
puts g.respond_to?(:describe)
puts g.respond_to?(:fly)
puts g.is_a?(Gadget)
puts g.kind_of?(Object)
puts g.instance_of?(Object)
puts Gadget.instance_methods(false).inspect
puts g.public_methods(false).inspect
puts g.class.name
puts 5.respond_to?(:+)
puts [1, 2].respond_to?(:each)
puts g.instance_variable_defined?(:@color)
