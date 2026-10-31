# Euler's totient by factorisation and by sieve.
def phi(n)
  result = n
  p = 2
  m = n
  while p * p <= m
    if (m % p).zero?
      m /= p while (m % p).zero?
      result -= result / p
    end
    p += 1
  end
  result -= result / m if m > 1
  result
end

def phi_sieve(limit)
  t = (0..limit).to_a
  (2..limit).each do |i|
    next unless t[i] == i
    (i..limit).step(i) { |j| t[j] -= t[j] / i }
  end
  t
end

puts (1..20).map { |n| phi(n) }.inspect
puts phi_sieve(20)[1..].inspect
puts phi(1_000_000)
puts "sum of phi(1..100): #{phi_sieve(100).sum}"
puts "n/phi(n) is largest below 1000 at #{(2...1000).max_by { |n| n.fdiv(phi(n)) }}"
puts "Euler's theorem 7^phi(10) mod 10 = #{7.pow(phi(10), 10)}"
