# Asking classes and objects about their relationships.
class Vehicle; end
class Car < Vehicle; end
class SportsCar < Car; end
module Electric; end
class Tesla < SportsCar
  include Electric
end

t = Tesla.new
puts t.is_a?(Car)
puts t.instance_of?(Car)
puts t.is_a?(Electric)
puts Tesla < Vehicle
puts Vehicle < Tesla
puts (Car <=> SportsCar)
puts Tesla.superclass
puts Tesla.ancestors.take_while { |a| a != Object }.inspect
puts Tesla.include?(Electric)
puts SportsCar.include?(Electric)
puts Car.instance_of?(Class)
puts Electric.class
puts [Car, Tesla, Vehicle, SportsCar].sort { |a, b| a <=> b || 0 }.inspect
chain = []
k = Tesla
while k
  chain << k
  k = k.superclass
end
puts chain.map(&:to_s).join(" -> ")
