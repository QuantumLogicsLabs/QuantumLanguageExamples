# Value objects with ==, eql? and hash.
class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(other) = other.is_a?(Point) && x == other.x && y == other.y
  alias eql? ==
  def hash = [x, y].hash
  def to_s = "(#{x}, #{y})"
  def inspect = "#<Point #{x},#{y}>"
  def distance_to(o) = Math.sqrt((x - o.x)**2 + (y - o.y)**2)
end

a = Point.new(1, 2)
b = Point.new(1, 2)
c = Point.new(4, 6)
puts a == b
puts a.equal?(b)
puts a.eql?(b)
puts [a, b, c].uniq.inspect
visits = { a => "home" }
puts visits[b]
puts a.distance_to(c)
puts "#{a} -> #{c}"
puts [c, a].include?(Point.new(4, 6))
