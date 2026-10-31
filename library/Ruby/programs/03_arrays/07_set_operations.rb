# Union, intersection and difference on arrays.
morning = %w[ana ben cy dee]
evening = %w[cy dee eli fay]

puts "Both shifts:   #{(morning & evening).inspect}"
puts "Any shift:     #{(morning | evening).inspect}"
puts "Morning only:  #{(morning - evening).inspect}"
puts "Evening only:  #{(evening - morning).inspect}"
puts "Exactly one:   #{((morning | evening) - (morning & evening)).inspect}"
puts "Overlap?       #{morning.intersect?(evening)}"
puts "Union method:  #{morning.union(evening, %w[gus]).inspect}"
puts "Difference:    #{morning.difference(evening, %w[ana]).inspect}"
puts "Subset?        #{(%w[cy dee] - morning).empty?}"
puts "Dupes kept by +: #{(morning + evening).inspect}"
