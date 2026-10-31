# One-line endless method definitions.
def square(x) = x * x
def cube(x) = x * square(x)
def even?(n) = (n % 2).zero?
def greeting(name = "world") = "Hello, #{name}!"
def clamp(v, lo, hi) = [[v, lo].max, hi].min
def average(*xs) = xs.sum.fdiv(xs.size)

puts square(7)
puts cube(3)
puts even?(10)
puts greeting
puts greeting("Ruby")
puts clamp(15, 0, 10)
puts clamp(-3, 0, 10)
puts average(1, 2, 3, 4)

class Vector2
  attr_reader :x, :y
  def initialize(x, y) = (@x, @y = x, y)
  def +(other) = Vector2.new(x + other.x, y + other.y)
  def length = Math.sqrt(x**2 + y**2)
  def to_s = "(#{x}, #{y})"
end

v = Vector2.new(3, 4) + Vector2.new(1, -1)
puts v
puts Vector2.new(3, 4).length
