# Constants, frozen objects and a lookup table.
SPEED_OF_LIGHT = 299_792_458
PLANETS = %w[Mercury Venus Earth Mars].freeze
GRAVITY = { "Mercury" => 3.7, "Venus" => 8.87, "Earth" => 9.81, "Mars" => 3.71 }.freeze

puts "Light travels #{SPEED_OF_LIGHT} m/s"
puts "In one minute: #{SPEED_OF_LIGHT * 60} m"
puts "Planets frozen? #{PLANETS.frozen?}"

PLANETS.each do |planet|
  weight = 70 * GRAVITY[planet] / GRAVITY["Earth"]
  puts "#{planet.ljust(8)} 70 kg feels like #{weight.round(1)} kg"
end

begin
  PLANETS << "Pluto"
rescue FrozenError => e
  puts "Cannot add Pluto: #{e.class}"
end
