# Prime factorisation and divisor counts.
def factorize(n)
  factors = Hash.new(0)
  d = 2
  while d * d <= n
    while (n % d).zero?
      factors[d] += 1
      n /= d
    end
    d += 1
  end
  factors[n] += 1 if n > 1
  factors
end

def show(factors)
  factors.map { |p, e| e > 1 ? "#{p}^#{e}" : p.to_s }.join(" x ")
end

[12, 97, 360, 1001, 2**10, 600_851_475_143, 9_699_690].each do |n|
  f = factorize(n)
  divisors = f.values.reduce(1) { |acc, e| acc * (e + 1) }
  puts "#{n} = #{show(f)} (#{divisors} divisors)"
end
