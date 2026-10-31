# A vehicle hierarchy with shared trip costs.
class Vehicle
  attr_reader :name

  def initialize(name) = @name = name
  def cost_per_km = raise(NotImplementedError)
  def trip_cost(km) = (cost_per_km * km).round(2)
  def to_s = "#{name} (#{self.class.name.downcase})"
end

class PetrolCar < Vehicle
  def initialize(name, l_per_100km, price_per_l = 1.8)
    super(name)
    @consumption, @price = l_per_100km, price_per_l
  end

  def cost_per_km = @consumption / 100.0 * @price
end

class ElectricCar < Vehicle
  def initialize(name, kwh_per_100km, price_per_kwh = 0.3)
    super(name)
    @consumption, @price = kwh_per_100km, price_per_kwh
  end

  def cost_per_km = @consumption / 100.0 * @price
end

class Bicycle < Vehicle
  def cost_per_km = 0.0
end

fleet = [PetrolCar.new("Golf", 6.5), ElectricCar.new("Leaf", 17), PetrolCar.new("Van", 11, 1.75), Bicycle.new("Bike")]
[25, 300].each do |km|
  puts "Trip of #{km} km:"
  fleet.sort_by { |v| v.trip_cost(km) }.each { |v| puts "  #{v.to_s.ljust(22)} #{format('%7.2f', v.trip_cost(km))}" }
end
