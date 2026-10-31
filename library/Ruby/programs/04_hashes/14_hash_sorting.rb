# Sorting hash entries by key and by value.
sales = { "north" => 1200, "south" => 950, "east" => 1500, "west" => 950, "central" => 700 }

puts sales.sort.inspect
puts sales.sort_by { |_, v| v }.inspect
puts sales.sort_by { |k, v| [-v, k] }.to_h.inspect
puts sales.max_by(2) { |_, v| v }.map(&:first).inspect
puts sales.sort_by { |k, _| k.length }.first.inspect

ranked = sales.sort_by { |k, v| [-v, k] }
ranked.each_with_index do |(region, amount), i|
  puts "#{i + 1}. #{region.capitalize.ljust(8)} #{amount.to_s.rjust(5)}"
end
