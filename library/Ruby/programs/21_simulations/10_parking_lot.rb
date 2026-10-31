# A parking lot with sized spots and hourly fees.
class ParkingLot
  RATES = { motorcycle: 1, car: 3, van: 5 }.freeze
  FITS = { motorcycle: %i[small medium large], car: %i[medium large], van: %i[large] }.freeze

  def initialize(spots)
    @spots = spots.to_h { |id, size| [id, { size: size, vehicle: nil }] }
    @income = 0
  end

  def park(plate, kind, hour)
    id, = @spots.find { |_, s| s[:vehicle].nil? && FITS[kind].include?(s[:size]) }
    return "#{plate}: no space for #{kind}" unless id
    @spots[id][:vehicle] = [plate, kind, hour]
    "#{plate} (#{kind}) parked in #{id}"
  end

  def leave(plate, hour)
    id, spot = @spots.find { |_, s| s[:vehicle]&.first == plate }
    return "#{plate}: not found" unless id
    _, kind, arrived = spot[:vehicle]
    spot[:vehicle] = nil
    fee = [hour - arrived, 1].max * RATES[kind]
    @income += fee
    "#{plate} left #{id}, paid #{fee}"
  end

  def occupancy = "#{@spots.count { |_, s| s[:vehicle] }}/#{@spots.size}, income #{@income}"
end

lot = ParkingLot.new([["S1", :small], ["M1", :medium], ["M2", :medium], ["L1", :large]])
puts lot.park("BIKE1", :motorcycle, 8)
puts lot.park("CAR1", :car, 8)
puts lot.park("VAN1", :van, 9)
puts lot.park("CAR2", :car, 9)
puts lot.park("CAR3", :car, 10)
puts lot.leave("CAR1", 12)
puts lot.park("CAR3", :car, 12)
puts lot.leave("VAN1", 15)
puts lot.leave("NOPE", 15)
puts lot.occupancy
