# Looking up constants and classes by name.
module Shapes
  class Circle
    def initialize(r) = @r = r
    def area = (Math::PI * @r**2).round(2)
  end

  class Square
    def initialize(s) = @s = s
    def area = @s * @s
  end

  DEFAULT = "Square"
end

%w[Circle Square].each do |name|
  klass = Shapes.const_get(name)
  puts "#{klass}: area of size 3 = #{klass.new(3).area}"
end
puts Shapes.const_get(Shapes::DEFAULT).new(5).area
puts Shapes.constants.sort.inspect
puts Shapes.const_defined?(:Triangle)
puts Object.const_get("Shapes::Circle").name
Shapes.const_set(:VERSION, "1.0")
puts Shapes::VERSION
klass = Object.const_get("Comparable")
puts klass.class
puts Math.const_get(:PI).round(3)
