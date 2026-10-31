# each_slice, each_cons, chunk_while and slice_when.
nums = [1, 2, 3, 5, 6, 9, 10, 11, 12, 15]

puts nums.each_slice(3).to_a.inspect
puts nums.each_cons(2).map { |a, b| b - a }.inspect
runs = nums.chunk_while { |a, b| b == a + 1 }.to_a
puts runs.inspect
puts runs.map { |r| r.size > 1 ? "#{r.first}-#{r.last}" : r.first.to_s }.join(",")
puts nums.slice_when { |a, b| b > a + 2 }.to_a.inspect

temps = [18, 21, 25, 24, 19, 17, 22]
rising = temps.each_cons(2).count { |a, b| b > a }
puts "Temperature rose #{rising} times"
puts temps.chunk { |t| t >= 20 ? :warm : :cool }.map { |k, v| "#{k}:#{v.size}" }.join(" ")
