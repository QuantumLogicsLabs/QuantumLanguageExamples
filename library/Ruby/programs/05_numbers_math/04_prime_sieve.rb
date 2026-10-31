# Sieve of Eratosthenes and prime statistics.
def sieve(limit)
  is_prime = Array.new(limit + 1, true)
  is_prime[0] = is_prime[1] = false
  (2..Math.sqrt(limit)).each do |i|
    next unless is_prime[i]
    (i * i).step(limit, i) { |j| is_prime[j] = false }
  end
  is_prime.each_index.select { |i| is_prime[i] }
end

primes = sieve(200)
puts primes.first(25).inspect
puts "Primes below 200: #{primes.size}"
puts "Sum: #{primes.sum}"
twins = primes.each_cons(2).select { |a, b| b - a == 2 }
puts "Twin primes: #{twins.map { |a, b| "(#{a},#{b})" }.join(' ')}"
gaps = primes.each_cons(2).map { |a, b| b - a }
puts "Largest gap: #{gaps.max} after #{primes[gaps.index(gaps.max)]}"
puts "Primes below 10_000: #{sieve(10_000).size}"
