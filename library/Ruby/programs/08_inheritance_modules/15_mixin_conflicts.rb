# When two modules define the same method, the last included wins.
module Swimmer
  def move = "swims"
  def describe = "I #{move}"
end

module Runner
  def move = "runs"
end

class Triathlete
  include Swimmer
  include Runner
end

class Diver
  include Runner
  include Swimmer
end

puts Triathlete.new.describe
puts Diver.new.describe
puts Triathlete.ancestors.take(3).inspect
puts Diver.ancestors.take(3).inspect

class Triathlete
  def move = "#{super} and cycles"
end
puts Triathlete.new.describe
