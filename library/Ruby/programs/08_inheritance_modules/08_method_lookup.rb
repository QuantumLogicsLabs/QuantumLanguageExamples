# Method resolution order with include, prepend and super.
module Loud
  def speak = super.upcase + "!"
end

module Polite
  def speak = "please, " + super
end

module Tracing
  def speak = "[trace] " + super
end

class Speaker
  def speak = "hello"
end

class Announcer < Speaker
  include Polite
  include Loud
  prepend Tracing
  def speak = "announcing: " + super
end

puts Announcer.new.speak
puts Announcer.ancestors.take(6).inspect
puts Announcer.instance_method(:speak).owner
puts Announcer.new.method(:speak).super_method.owner
