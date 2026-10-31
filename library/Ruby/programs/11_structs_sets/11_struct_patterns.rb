# Pattern matching on structs and Data.
Point = Struct.new(:x, :y)
Circle = Data.define(:center, :radius)
Segment = Data.define(:from, :to)

def describe(shape)
  case shape
  in Circle[center: Point[x: 0, y: 0], radius:]
    "circle at origin, r=#{radius}"
  in Circle[center: Point[x:, y:], radius:] if radius > 10
    "big circle at #{x},#{y}"
  in Circle[center:, radius:]
    "circle r=#{radius} at #{center.to_a.inspect}"
  in Segment[from: Point[x:, y: y1], to: Point[x: ^x, y: y2]]
    "vertical segment at x=#{x}, length #{(y2 - y1).abs}"
  in Segment[from:, to:]
    "segment #{from.to_a} -> #{to.to_a}"
  in Point[x, y]
    "point #{x},#{y}"
  end
end

[Circle.new(Point.new(0, 0), 5), Circle.new(Point.new(2, 3), 20), Circle.new(Point.new(1, 1), 2),
 Segment.new(Point.new(4, 1), Point.new(4, 9)), Segment.new(Point.new(0, 0), Point.new(3, 4)), Point.new(7, 8)]
  .each { |s| puts describe(s) }
