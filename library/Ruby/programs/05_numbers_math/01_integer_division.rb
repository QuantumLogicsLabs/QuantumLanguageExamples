# Integer division, modulo and their signs.
pairs = [[17, 5], [-17, 5], [17, -5], [-17, -5]]
pairs.each do |a, b|
  puts "#{a} / #{b} = #{a / b}, #{a} % #{b} = #{a % b}, divmod #{a.divmod(b).inspect}, remainder #{a.remainder(b)}"
end

puts 7.fdiv(2)
puts 7 / 2.0
puts 10.0 / 4
puts 2**10
puts 2**-2
puts 10.pow(3, 7)
puts -7.abs
puts 7.0 / 0
puts (0.0 / 0).nan?

minutes = 1000
hours, mins = minutes.divmod(60)
days, hours = hours.divmod(24)
puts "#{minutes} minutes = #{days}d #{hours}h #{mins}m"
