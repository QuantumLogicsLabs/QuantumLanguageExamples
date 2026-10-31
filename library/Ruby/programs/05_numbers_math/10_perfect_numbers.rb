# Perfect, abundant and deficient numbers, and amicable pairs.
def divisor_sum(n)
  return 0 if n < 2
  sum = 1
  (2..Math.sqrt(n)).each do |d|
    next unless (n % d).zero?
    sum += d
    sum += n / d unless d * d == n
  end
  sum
end

kinds = Hash.new { |h, k| h[k] = [] }
(1..30).each do |n|
  s = divisor_sum(n)
  kind = s == n ? :perfect : s > n ? :abundant : :deficient
  kinds[kind] << n
end
kinds.each { |k, list| puts "#{k}: #{list.inspect}" }

perfect = (2..10_000).select { |n| divisor_sum(n) == n }
puts "Perfect numbers below 10000: #{perfect.inspect}"
amicable = (2..3000).filter_map do |a|
  b = divisor_sum(a)
  [a, b] if b > a && divisor_sum(b) == a
end
puts "Amicable pairs below 3000: #{amicable.inspect}"
