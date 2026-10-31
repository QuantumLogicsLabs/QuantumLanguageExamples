# Greatest common divisor and least common multiple.
def euclid(a, b)
  b.zero? ? a : euclid(b, a % b)
end

def extended_gcd(a, b)
  return [a, 1, 0] if b.zero?
  g, x, y = extended_gcd(b, a % b)
  [g, y, x - (a / b) * y]
end

[[48, 18], [101, 103], [270, 192], [1071, 462]].each do |a, b|
  g, x, y = extended_gcd(a, b)
  puts "gcd(#{a}, #{b}) = #{euclid(a, b)} = #{a.gcd(b)}, lcm #{a.lcm(b)}, #{a}*#{x} + #{b}*#{y} = #{g}"
end

nums = [12, 18, 30, 42]
puts "gcd of #{nums.inspect}: #{nums.reduce(:gcd)}"
puts "lcm of 1..10: #{(1..10).reduce(:lcm)}"
puts "lcm of 1..20: #{(1..20).reduce(1) { |acc, n| acc.lcm(n) }}"
