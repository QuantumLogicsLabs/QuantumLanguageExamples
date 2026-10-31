# Classifies numbers: parity, sign, primality and perfect squares.
def prime?(n)
  return false if n < 2
  (2..Math.sqrt(n)).none? { |d| (n % d).zero? }
end

def perfect_square?(n)
  n >= 0 && Math.sqrt(n).to_i**2 == n
end

[-7, 0, 1, 2, 9, 15, 16, 17, 25, 29, 100].each do |n|
  traits = []
  traits << (n.even? ? "even" : "odd")
  traits << (n.positive? ? "positive" : n.negative? ? "negative" : "zero")
  traits << "prime" if prime?(n)
  traits << "square" if perfect_square?(n)
  puts "#{n.to_s.rjust(4)}: #{traits.join(', ')}"
end
