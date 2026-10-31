# Finding extremes and totals by a key.
cities = [
  { name: "Oslo", pop: 709, temp: 6.3 },
  { name: "Cairo", pop: 10_230, temp: 22.1 },
  { name: "Lima", pop: 10_719, temp: 19.4 },
  { name: "Reykjavik", pop: 139, temp: 5.2 },
  { name: "Perth", pop: 2_141, temp: 18.8 }
]

puts cities.min_by { |c| c[:pop] }[:name]
puts cities.max_by { |c| c[:temp] }[:name]
puts cities.minmax_by { |c| c[:name].length }.map { |c| c[:name] }.inspect
puts cities.sum { |c| c[:pop] }
puts (cities.sum { |c| c[:temp] } / cities.size).round(2)
puts cities.max_by(2) { |c| c[:pop] }.map { |c| c[:name] }.inspect
puts cities.min(2) { |a, b| a[:temp] <=> b[:temp] }.map { |c| c[:name] }.inspect
puts cities.sort_by { |c| -c[:pop] }.map { |c| c[:name] }.first(3).inspect
puts cities.count { |c| c[:temp] > 15 }
puts cities.map { |c| c[:name] }.max
puts cities.map { |c| c[:pop] }.minmax.inspect
