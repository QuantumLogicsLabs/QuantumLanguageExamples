# Deterministic Miller-Rabin for 64-bit integers.
BASES = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37].freeze

def prime?(n)
  return false if n < 2
  BASES.each { |p| return n == p if (n % p).zero? }
  d = n - 1
  r = 0
  while d.even?
    d /= 2
    r += 1
  end
  BASES.all? do |a|
    x = a.pow(d, n)
    next true if x == 1 || x == n - 1
    (r - 1).times.any? { x = x * x % n; x == n - 1 }
  end
end

[2, 1, 561, 7919, 1_000_000_007, 2**61 - 1, 2**61 + 1, 999_999_999_989, 3_215_031_751].each do |n|
  puts "#{n}: #{prime?(n)}"
end
puts (1..100).select { |n| prime?(n) }.size
puts "next prime after 10^12: #{(10**12..).find { |n| prime?(n) }}"
