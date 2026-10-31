# Sorting records by several keys.
people = [
  ["Kim", 34, "Seoul"],
  ["Ana", 28, "Lima"],
  ["Ben", 34, "Oslo"],
  ["Zoe", 22, "Lima"],
  ["Ali", 28, "Cairo"]
]

puts "By name:"
people.sort_by(&:first).each { |p| puts "  #{p.inspect}" }
puts "By age then name:"
people.sort_by { |n, a, _| [a, n] }.each { |p| puts "  #{p.inspect}" }
puts "By age descending then name:"
people.sort { |x, y| [y[1], x[0]] <=> [x[1], y[0]] }.each { |p| puts "  #{p.inspect}" }
puts "Oldest: #{people.max_by { |p| p[1] }.first}"
puts "Cities: #{people.map(&:last).uniq.sort.join(', ')}"
puts "Min and max age: #{people.map { |p| p[1] }.minmax.inspect}"
