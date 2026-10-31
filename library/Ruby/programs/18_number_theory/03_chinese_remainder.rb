# Solving simultaneous congruences.
def ext_gcd(a, b)
  return [a, 1, 0] if b.zero?
  g, x, y = ext_gcd(b, a % b)
  [g, y, x - a / b * y]
end

def crt(remainders, moduli)
  x, m = 0, 1
  remainders.zip(moduli).each do |r, n|
    g, p, _ = ext_gcd(m, n)
    return nil unless ((r - x) % g).zero?
    lcm = m / g * n
    x = (x + (r - x) / g * p % (n / g) * m) % lcm
    m = lcm
  end
  [x, m]
end

puts crt([2, 3, 2], [3, 5, 7]).inspect
puts crt([1, 2, 3, 4], [5, 7, 9, 11]).inspect
puts crt([3, 4], [6, 8]).inspect
puts crt([1, 3], [4, 6]).inspect
x, m = crt([0, 1, 2], [3, 4, 5])
puts "smallest n with n%3=0, n%4=1, n%5=2: #{x} (period #{m})"
puts (1..1000).select { |n| n % 3 == 0 && n % 4 == 1 && n % 5 == 2 }.first(3).inspect
