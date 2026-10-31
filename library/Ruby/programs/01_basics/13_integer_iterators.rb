# times, upto, downto and step.
3.times { |i| puts "times: #{i}" }
1.upto(4) { |i| print i * i, " " }
puts
10.downto(7) { |i| print i, " " }
puts
0.step(20, 5) { |i| print i, " " }
puts
1.0.step(2.0, 0.25) { |x| print x, " " }
puts

triangle = []
1.upto(5) { |row| triangle << (1..row).to_a }
triangle.each { |row| puts row.join(" ").center(9) }

sum = 0
1.step(99, 2) { |odd| sum += odd }
puts "Sum of odd numbers below 100: #{sum}"
