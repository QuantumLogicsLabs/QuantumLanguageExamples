# Fast modular exponentiation and the Fermat primality test.
def mod_pow(base, exp, mod)
  result = 1
  base %= mod
  while exp.positive?
    result = result * base % mod if exp.odd?
    base = base * base % mod
    exp >>= 1
  end
  result
end

def fermat_probable_prime?(n, bases = [2, 3, 5, 7])
  return n == 2 || n == 3 if n < 4
  bases.all? { |a| a % n == 0 || mod_pow(a, n - 1, n) == 1 }
end

puts mod_pow(2, 10, 1000)
puts mod_pow(3, 200, 13)
puts mod_pow(7, 10**18, 1_000_000_007)
puts mod_pow(7, 10**18, 1_000_000_007) == 7.pow(10**18, 1_000_000_007)
[97, 561, 1105, 7919, 8911, 10_007].each do |n|
  puts "#{n}: fermat says #{fermat_probable_prime?(n) ? 'prime' : 'composite'}"
end
