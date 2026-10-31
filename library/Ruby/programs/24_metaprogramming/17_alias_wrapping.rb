# Wrapping existing methods with alias_method.
class Greeter
  def greet(name) = "Hello, #{name}"
end

class Greeter
  alias_method :plain_greet, :greet

  def greet(name)
    result = plain_greet(name.strip.capitalize)
    "#{result}!"
  end
end

puts Greeter.new.greet("  ruby ")
puts Greeter.new.plain_greet("world")
puts Greeter.instance_methods(false).sort.inspect

class String
  alias_method :original_length, :length
end
puts "abc".original_length

module Timing
  def self.wrap(klass, method_name, log)
    original = klass.instance_method(method_name)
    klass.define_method(method_name) do |*args|
      log << "before #{method_name}(#{args.join(', ')})"
      r = original.bind(self).call(*args)
      log << "after #{method_name} => #{r}"
      r
    end
  end
end

log = []
Timing.wrap(Greeter, :greet, log)
Greeter.new.greet("mars")
puts log
