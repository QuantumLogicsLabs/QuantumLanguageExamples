# Readers, writers and validating setters.
class Thermostat
  attr_reader :target
  attr_accessor :name
  attr_writer :unit

  RANGE = (10..30).freeze

  def initialize(name)
    @name = name
    @target = 20
    @unit = "C"
  end

  def target=(value)
    raise ArgumentError, "#{value} is outside #{RANGE}" unless RANGE.cover?(value)
    @target = value
  end

  def to_s = "#{name}: #{target}#{@unit}"
end

t = Thermostat.new("Hall")
puts t
t.target = 23
t.name = "Hallway"
puts t
[35, 5].each do |v|
  t.target = v
rescue ArgumentError => e
  puts "Rejected: #{e.message}"
end
t.unit = "°C"
puts t
puts t.target
