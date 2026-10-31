# Class-level state that subclasses keep separately.
class Shape
  class << self
    attr_accessor :count
  end
  self.count = 0

  def self.inherited(sub)
    super
    sub.count = 0
  end

  def initialize
    self.class.count += 1
  end
end

class Circle < Shape; end
class Square < Shape; end

3.times { Circle.new }
Square.new
Shape.new
puts "Shapes: #{Shape.count}"
puts "Circles: #{Circle.count}"
puts "Squares: #{Square.count}"
puts Circle.superclass
puts Circle.ancestors.take(3).inspect
