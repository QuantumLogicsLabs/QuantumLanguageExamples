# Modular inverses and solving linear congruences.
def inverse(a, m)
  t, new_t = 0, 1
  r, new_r = m, a % m
  until new_r.zero?
    q = r / new_r
    t, new_t = new_t, t - q * new_t
    r, new_r = new_r, r - q * new_r
  end
  r == 1 ? t % m : nil
end

[[3, 11], [10, 17], [6, 9], [7, 26], [17, 3120]].each do |a, m|
  inv = inverse(a, m)
  puts "#{a}^-1 mod #{m} = #{inv.inspect}#{inv ? " (check #{a * inv % m})" : ''}"
end

p = 1_000_000_007
fact = (1..20).reduce([1]) { |acc, i| acc << acc.last * i % p }
choose = ->(n, k) { fact[n] * inverse(fact[k], p) % p * inverse(fact[n - k], p) % p }
puts "C(20, 7) mod p = #{choose.(20, 7)} (exact #{(14..20).reduce(:*) / (1..7).reduce(:*)})"
