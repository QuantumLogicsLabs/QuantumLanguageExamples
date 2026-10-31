# The Math module.
puts Math.sqrt(144)
puts Math.cbrt(27)
puts Math.hypot(3, 4)
puts Math.log(Math::E)
puts Math.log10(1000)
puts Math.log2(1024)
puts Math.log(8, 2)
puts Math.exp(1) == Math::E
puts Math::PI.round(6)
puts Math.sin(Math::PI / 6).round(6)
puts Math.cos(0)
puts Math.atan2(1, 1).round(6)
puts (Math.atan(1) * 4).round(10)

def degrees(rad) = rad * 180 / Math::PI
puts degrees(Math::PI / 3).round(6)
area = ->(r) { Math::PI * r**2 }
[1, 2.5, 10].each { |r| puts "circle r=#{r}: area #{area.(r).round(3)}" }
