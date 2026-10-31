# Creating, reading and changing hashes.
capitals = { "France" => "Paris", "Japan" => "Tokyo", "Peru" => "Lima" }
capitals["Kenya"] = "Nairobi"

puts capitals["Japan"]
puts capitals["Mars"].inspect
puts capitals.fetch("Peru")
puts capitals.fetch("Mars", "unknown")
puts capitals.fetch("Mars") { |k| "no capital for #{k}" }
puts capitals.key?("France")
puts capitals.value?("Lima")
puts capitals.key("Tokyo")
puts capitals.size
puts capitals.keys.inspect
puts capitals.values.inspect
removed = capitals.delete("France")
puts "removed #{removed}, left #{capitals.size}"
puts capitals.to_a.inspect
puts capitals.any? { |_, city| city.start_with?("N") }
puts capitals.empty?
