# Arbitrary precision integers.
def factorial(n)
  (1..n).reduce(1, :*)
end

puts factorial(25)
puts factorial(50)
puts factorial(50).to_s.length
puts 2**100
puts (2**100).to_s.chars.map(&:to_i).sum
puts (3**200 % 1_000_000_007)
puts 123_456_789 * 987_654_321
puts (10**30 + 1) / 7
puts (10**30).class
fib = [0, 1]
fib << fib[-1] + fib[-2] while fib.size < 120
puts fib.last
puts "Trailing zeros of 100!: #{factorial(100).to_s[/0*\z/].length}"
