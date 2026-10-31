# Classes that support pattern matching.
class Point
  attr_reader :x, :y
  def initialize(x, y) = (@x, @y = x, y)
  def deconstruct = [x, y]
  def deconstruct_keys(_keys) = { x: x, y: y }
end

class Color
  attr_reader :r, :g, :b
  def initialize(hex) = (@r, @g, @b = hex.scan(/\h\h/).map(&:hex))
  def deconstruct_keys(keys) = { r: r, g: g, b: b, gray: r == g && g == b }.slice(*(keys || %i[r g b gray]))
end

def where(p)
  case p
  in [0, 0] then "origin"
  in { x: 0 } then "on the y axis"
  in Point(x:, y:) if x == y then "on the diagonal at #{x}"
  in Point[x, y] then "at #{x},#{y}"
  end
end

[Point.new(0, 0), Point.new(0, 5), Point.new(3, 3), Point.new(2, 7)].each { |p| puts where(p) }

%w[#808080 #ff0000 #00ff7f].each do |hex|
  desc = case Color.new(hex)
         in { gray: true, r: } then "gray level #{r}"
         in { r: 255, g: 0, b: 0 } then "pure red"
         in { r:, g:, b: } then "rgb(#{r}, #{g}, #{b})"
         end
  puts "#{hex}: #{desc}"
end
