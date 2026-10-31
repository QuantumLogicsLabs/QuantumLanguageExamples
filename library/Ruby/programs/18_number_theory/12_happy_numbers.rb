# Happy numbers: repeated digit-square sums reaching 1.
def next_value(n) = n.digits.sum { |d| d * d }

def happy?(n)
  seen = []
  until n == 1 || seen.include?(n)
    seen << n
    n = next_value(n)
  end
  n == 1
end

def chain(n)
  out = [n]
  out << next_value(out.last) until out.last == 1 || out.count(out.last) > 1
  out
end

puts (1..50).select { |n| happy?(n) }.inspect
puts chain(19).join(" -> ")
puts chain(4).join(" -> ")
puts "happy below 1000: #{(1...1000).count { |n| happy?(n) }}"
happy_primes = (2..200).select { |n| happy?(n) && (2..Integer.sqrt(n)).none? { |d| (n % d).zero? } }
puts "happy primes below 200: #{happy_primes.inspect}"
