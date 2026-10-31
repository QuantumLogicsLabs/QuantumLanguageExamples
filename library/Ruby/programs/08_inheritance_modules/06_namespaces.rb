# Modules as namespaces with constants and nested classes.
module Geometry
  PI_APPROX = 3.14159

  module Units
    CM_PER_INCH = 2.54
    def self.inches_to_cm(i) = (i * CM_PER_INCH).round(2)
  end

  class Point
    attr_reader :x, :y
    def initialize(x, y) = (@x, @y = x, y)
    def to_s = "Geometry::Point(#{x}, #{y})"
  end

  def self.circle_area(r) = (PI_APPROX * r * r).round(3)
end

module Graphics
  class Point
    def to_s = "a pixel"
  end
end

puts Geometry::PI_APPROX
puts Geometry.circle_area(2)
puts Geometry::Units.inches_to_cm(10)
puts Geometry::Units::CM_PER_INCH
puts Geometry::Point.new(1, 2)
puts Graphics::Point.new
puts Geometry::Point.name
puts Geometry.constants.sort.inspect
puts Geometry::Point == Graphics::Point
