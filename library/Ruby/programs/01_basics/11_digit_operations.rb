# Digit sums, reversal, palindromes and Armstrong numbers.
def digit_sum(n)
  n.abs.digits.sum
end

def reverse_number(n)
  n.to_s.reverse.to_i
end

def palindrome?(n)
  n.to_s == n.to_s.reverse
end

def armstrong?(n)
  d = n.digits
  d.sum { |x| x**d.size } == n
end

[12345, 9875, 1221, 400].each do |n|
  puts "#{n}: digit sum #{digit_sum(n)}, reversed #{reverse_number(n)}, palindrome #{palindrome?(n)}"
end

puts "Armstrong numbers below 1000: #{(1...1000).select { |n| armstrong?(n) }.inspect}"
puts "Digital root of 987654321: #{9876_54321.then { |n| n = digit_sum(n) while n > 9; n }}"
