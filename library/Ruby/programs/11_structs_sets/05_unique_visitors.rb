# Counting unique visitors with sets.
log = [
  "mon ana", "mon ben", "mon ana", "tue cy", "tue ana", "wed ben", "wed dee", "wed ana", "thu eli"
]

by_day = Hash.new { |h, k| h[k] = Set.new }
log.each do |line|
  day, user = line.split
  by_day[day] << user
end

by_day.each { |day, users| puts "#{day}: #{users.size} unique (#{users.to_a.sort.join(', ')})" }
all = by_day.values.reduce(:|)
puts "Total unique: #{all.size}"
every_day = by_day.values.reduce(:&)
puts "Visited every day: #{every_day.to_a.inspect}"
regulars = all.select { |u| by_day.count { |_, us| us.include?(u) } >= 2 }
puts "Visited 2+ days: #{regulars.sort.inspect}"
new_each_day = by_day.each_with_object([Set.new, {}]) do |(day, users), (seen, out)|
  out[day] = (users - seen).size
  seen.merge(users)
end.last
puts "New visitors per day: #{new_each_day.inspect}"
