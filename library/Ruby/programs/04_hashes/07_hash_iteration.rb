# Iterating hashes in various ways.
populations = { "Tokyo" => 37.4, "Delhi" => 31.0, "Shanghai" => 27.1, "Sao Paulo" => 22.0, "Cairo" => 21.3 }

populations.each_pair { |city, m| puts "#{city}: #{m}M" }
populations.each_with_index { |(city, m), i| puts "#{i + 1}. #{city} (#{m})" }
puts populations.map { |city, m| "#{city[0, 3].upcase}=#{m.round}" }.join(" ")
puts populations.sum { |_, m| m }.round(1)
puts populations.min_by { |_, m| m }.first
puts populations.sort_by { |city, _| city }.map(&:first).inspect
puts populations.count { |_, m| m > 25 }
puts populations.find { |_, m| m < 25 }.inspect
populations.each_key { |c| print c.length, " " }
puts
populations.each_value { |m| print (m * 1000).to_i, " " }
puts
