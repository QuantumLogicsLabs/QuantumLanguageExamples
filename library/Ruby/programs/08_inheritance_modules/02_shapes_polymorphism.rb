# An abstract base class with concrete shapes.
class Shape
  def area = raise(NotImplementedError, "#{self.class} must implement area")
  def perimeter = raise(NotImplementedError, "#{self.class} must implement perimeter")
  def to_s = format("%-10s area %8.3f  perimeter %7.3f", self.class.name, area, perimeter)
end

class Rectangle < Shape
  def initialize(w, h) = (@w, @h = w, h)
  def area = @w * @h
  def perimeter = 2 * (@w + @h)
end

class Square < Rectangle
  def initialize(side) = super(side, side)
end

class Circle < Shape
  def initialize(r) = @r = r
  def area = Math::PI * @r**2
  def perimeter = 2 * Math::PI * @r
end

class Triangle < Shape
  def initialize(a, b, c) = @sides = [a, b, c]
  def perimeter = @sides.sum
  def area
    s = perimeter / 2.0
    Math.sqrt(@sides.reduce(s) { |acc, x| acc * (s - x) })
  end
end

shapes = [Rectangle.new(3, 4), Square.new(2.5), Circle.new(1), Triangle.new(3, 4, 5)]
shapes.each { |s| puts s }
puts "Largest: #{shapes.max_by(&:area).class}"
begin
  Shape.new.area
rescue NotImplementedError => e
  puts "Error: #{e.message}"
end
