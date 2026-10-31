# Methods defined on single objects and class << self.
robot = Object.new
def robot.greet = "Beep boop"
robot.define_singleton_method(:dance) { "*spins*" }
puts robot.greet
puts robot.dance
puts robot.singleton_methods.sort.inspect

other = Object.new
puts other.respond_to?(:greet)

class Config
  class << self
    def settings = @settings ||= {}
    def set(key, value) = settings[key] = value
    def get(key) = settings.fetch(key, "unset")
  end
end

Config.set(:mode, "fast")
Config.set(:level, 3)
puts Config.get(:mode)
puts Config.get(:missing)
puts Config.settings.inspect

str = "hello"
str.define_singleton_method(:shout) { upcase + "!" }
puts str.shout
