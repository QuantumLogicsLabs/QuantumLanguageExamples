# Classic recursive definitions.
def factorial(n) = n <= 1 ? 1 : n * factorial(n - 1)
def fib(n) = n < 2 ? n : fib(n - 1) + fib(n - 2)
def sum_to(n) = n.zero? ? 0 : n + sum_to(n - 1)
def power(base, exp)
  return 1 if exp.zero?
  half = power(base, exp / 2)
  exp.even? ? half * half : half * half * base
end

puts (0..10).map { |n| factorial(n) }.inspect
puts factorial(30)
puts (0..20).map { |n| fib(n) }.inspect
puts sum_to(100)
puts power(3, 13)
puts power(2, 64)
puts power(7, 0)
