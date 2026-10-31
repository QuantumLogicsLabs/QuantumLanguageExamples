# Making numbers work on the left of custom operators with coerce.
class Vec
  attr_reader :x, :y

  def initialize(x, y) = (@x, @y = x, y)
  def +(o) = Vec.new(x + o.x, y + o.y)
  def *(k) = k.is_a?(Vec) ? x * k.x + y * k.y : Vec.new(x * k, y * k)
  def -@ = Vec.new(-x, -y)
  def ==(o) = o.is_a?(Vec) && x == o.x && y == o.y
  def to_s = "(#{x}, #{y})"
  def coerce(n) = [self, n]
end

v = Vec.new(2, 3)
w = Vec.new(-1, 4)
puts v + w
puts v * 3
puts 3 * v
puts 2.5 * w
puts v * w
puts -v
puts (v * 2) == (2 * v)
puts [v, w, Vec.new(0, 1)].reduce { |a, b| a + b }
