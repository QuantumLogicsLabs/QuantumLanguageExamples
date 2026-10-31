# Operator overloading on a Temperature class.
class Temperature
  include Comparable
  attr_reader :degrees

  def initialize(degrees) = @degrees = degrees.to_f
  def self.from_fahrenheit(f) = new((f - 32) * 5 / 9)

  def +(delta) = Temperature.new(degrees + delta)
  def -(other) = other.is_a?(Temperature) ? degrees - other.degrees : Temperature.new(degrees - other)
  def <=>(other) = degrees <=> other.degrees
  def fahrenheit = degrees * 9 / 5 + 32
  def to_s = format("%.1fC (%.1fF)", degrees, fahrenheit)
end

today = Temperature.new(21.5)
yesterday = Temperature.from_fahrenheit(64.4)
puts today
puts yesterday
puts today + 3
puts today - 1.5
puts "Difference: #{(today - yesterday).round(2)}"
puts today > yesterday
week = [18, 25.5, 21, 19.5, 30].map { |d| Temperature.new(d) }
puts "Hottest: #{week.max}"
puts "Sorted: #{week.sort.map(&:degrees).inspect}"
puts week.select { |t| t.between?(Temperature.new(19), Temperature.new(22)) }.map(&:degrees).inspect
