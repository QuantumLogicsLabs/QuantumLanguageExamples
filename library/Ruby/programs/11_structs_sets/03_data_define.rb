# Immutable value objects with Data.define.
Coord = Data.define(:lat, :lng) do
  def to_s = format("(%.3f, %.3f)", lat, lng)

  def distance_km(other)
    r = 6371.0
    dlat = (other.lat - lat) * Math::PI / 180
    dlng = (other.lng - lng) * Math::PI / 180
    a = Math.sin(dlat / 2)**2 + Math.cos(lat * Math::PI / 180) * Math.cos(other.lat * Math::PI / 180) * Math.sin(dlng / 2)**2
    2 * r * Math.asin(Math.sqrt(a))
  end
end

paris = Coord.new(lat: 48.8566, lng: 2.3522)
london = Coord.new(48.8566 + 2.6508, -0.1276)
puts paris
puts london
puts "Paris-London: #{paris.distance_km(london).round(1)} km"
moved = paris.with(lng: 2.0)
puts moved
puts paris.lng
puts paris == Coord.new(lat: 48.8566, lng: 2.3522)
puts paris.to_h.inspect
begin
  paris.instance_variable_set(:@lat, 0)
rescue => e
  puts e.class
end
puts Coord.members.inspect
