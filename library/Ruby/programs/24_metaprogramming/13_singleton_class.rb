# Singleton classes, class methods and extend.
class Report; end

class << Report
  def generate(title) = "== #{title} =="
  attr_accessor :default_format
end
Report.default_format = :pdf
puts Report.generate("Q1")
puts Report.default_format
puts Report.singleton_methods.sort.inspect

module Loud
  def speak = "#{name.upcase}!"
end

obj = Struct.new(:name).new("quiet")
obj.extend(Loud)
puts obj.speak
puts obj.singleton_class.ancestors.include?(Loud)
puts obj.singleton_class.instance_methods(false).inspect

counter = Object.new
counter.instance_variable_set(:@n, 0)
counter.singleton_class.class_eval do
  def tick = @n += 1
end
3.times { counter.tick }
puts counter.tick
