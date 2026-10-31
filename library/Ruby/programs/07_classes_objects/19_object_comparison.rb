# Spaceship-based sorting of custom objects.
class Version
  include Comparable
  attr_reader :parts

  def initialize(text) = @parts = text.split(".").map(&:to_i)
  def <=>(other) = parts <=> other.parts
  def to_s = parts.join(".")
  def major = parts[0]
end

versions = %w[1.10.0 1.2.9 2.0 1.2.10 0.9.12 1.10].map { |v| Version.new(v) }
puts versions.sort.join(" < ")
puts versions.max
puts versions.min
puts Version.new("1.2") < Version.new("1.10")
puts Version.new("2.0") == Version.new("2.0")
puts Version.new("1.5").clamp(Version.new("1.0"), Version.new("1.4"))
puts versions.group_by(&:major).transform_values { |vs| vs.sort.map(&:to_s) }.sort.inspect
