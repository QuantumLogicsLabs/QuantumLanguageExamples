# A 24-hour clock with modular arithmetic.
class Clock
  include Comparable
  MINUTES_PER_DAY = 24 * 60

  attr_reader :minutes

  def initialize(hours = 0, minutes = 0)
    @minutes = (hours * 60 + minutes) % MINUTES_PER_DAY
  end

  def self.parse(text)
    h, m = text.split(":").map(&:to_i)
    new(h, m)
  end

  def +(mins) = Clock.new(0, minutes + mins)
  def -(mins) = Clock.new(0, minutes - mins)
  def <=>(other) = minutes <=> other.minutes
  def to_s = format("%02d:%02d", *minutes.divmod(60))
end

puts Clock.new(8, 30)
puts Clock.new(25, 0)
puts Clock.new(0, -90)
puts Clock.parse("23:45") + 30
puts Clock.parse("00:10") - 25
puts Clock.new(10) == Clock.new(34)
alarms = %w[07:30 06:45 22:00 12:15].map { |t| Clock.parse(t) }
puts alarms.sort.join(" ")
puts "Next after noon: #{alarms.select { |a| a > Clock.new(12) }.min}"
