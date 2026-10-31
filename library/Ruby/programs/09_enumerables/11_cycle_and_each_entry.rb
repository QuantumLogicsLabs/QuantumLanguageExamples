# Repeating sequences with cycle.
colors = %w[red green blue]
puts colors.cycle.take(7).inspect
puts colors.cycle(2).to_a.inspect

players = %w[Ana Ben Cy]
turns = players.cycle
puts 5.times.map { |i| "turn #{i + 1}: #{turns.next}" }

pattern = [1, 0, 0]
signal = pattern.cycle.first(10)
puts signal.join

days = %w[Mon Tue Wed Thu Fri Sat Sun]
start = days.index("Fri")
puts days.rotate(start).cycle.take(10).join(" ")
puts (1..3).each_entry.to_a.inspect
stripes = %w[# .].cycle
puts 4.times.map { stripes.next * 3 }.join("|")
