# Checking Goldbach's conjecture for small even numbers.
LIMIT = 2000
sieve = Array.new(LIMIT + 1, true)
sieve[0] = sieve[1] = false
(2..Integer.sqrt(LIMIT)).each { |i| (i * i).step(LIMIT, i) { |j| sieve[j] = false } if sieve[i] }
primes = sieve.each_index.select { |i| sieve[i] }

def pairs(n, primes, sieve) = primes.take_while { |p| p <= n / 2 }.select { |p| sieve[n - p] }.map { |p| [p, n - p] }

[4, 28, 100, 98, 1000].each do |n|
  ps = pairs(n, primes, sieve)
  puts "#{n}: #{ps.size} ways, e.g. #{ps.first(3).map { |a, b| "#{a}+#{b}" }.join(', ')}"
end
holds = (4..LIMIT).step(2).all? { |n| !pairs(n, primes, sieve).empty? }
puts "Goldbach holds up to #{LIMIT}: #{holds}"
most = (4..LIMIT).step(2).max_by { |n| pairs(n, primes, sieve).size }
puts "most representations below #{LIMIT}: #{most} (#{pairs(most, primes, sieve).size})"
