# Recursion over digits.
def digit_sum(n) = n < 10 ? n : n % 10 + digit_sum(n / 10)
def digital_root(n) = n < 10 ? n : digital_root(digit_sum(n))
def to_binary(n) = n < 2 ? n.to_s : to_binary(n / 2) + (n % 2).to_s
def count_digits(n) = n < 10 ? 1 : 1 + count_digits(n / 10)
def gcd(a, b) = b.zero? ? a : gcd(b, a % b)

def number_words(n)
  ones = %w[zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen]
  tens = %w[_ _ twenty thirty forty fifty sixty seventy eighty ninety]
  if n < 20 then ones[n]
  elsif n < 100 then tens[n / 10] + (n % 10).zero?.then { |z| z ? "" : "-" + ones[n % 10] }
  elsif n < 1000 then ones[n / 100] + " hundred" + (n % 100).zero?.then { |z| z ? "" : " and " + number_words(n % 100) }
  else number_words(n / 1000) + " thousand" + ((n % 1000).zero? ? "" : " " + number_words(n % 1000))
  end
end

puts digit_sum(987654321)
puts digital_root(987654321)
puts to_binary(2024)
puts count_digits(1_000_000)
puts gcd(1071, 462)
[0, 7, 13, 42, 100, 315, 999, 2024, 70_017].each { |n| puts "#{n}: #{number_words(n)}" }
