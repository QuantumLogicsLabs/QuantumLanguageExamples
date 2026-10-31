# Fibonacci numbers computed several ways.
def fib_recursive(n) = n < 2 ? n : fib_recursive(n - 1) + fib_recursive(n - 2)

def fib_iterative(n)
  a, b = 0, 1
  n.times { a, b = b, a + b }
  a
end

def fib_matrix(n)
  result = [[1, 0], [0, 1]]
  base = [[1, 1], [1, 0]]
  mult = ->(x, y) { [[x[0][0] * y[0][0] + x[0][1] * y[1][0], x[0][0] * y[0][1] + x[0][1] * y[1][1]],
                     [x[1][0] * y[0][0] + x[1][1] * y[1][0], x[1][0] * y[0][1] + x[1][1] * y[1][1]]] }
  while n.positive?
    result = mult.(result, base) if n.odd?
    base = mult.(base, base)
    n >>= 1
  end
  result[0][1]
end

fib_enum = Enumerator.new do |y|
  a, b = 0, 1
  loop { y << a; a, b = b, a + b }
end

puts (0..15).map { |n| fib_recursive(n) }.inspect
puts fib_iterative(80)
puts fib_matrix(80)
puts fib_enum.take(12).inspect
puts fib_enum.lazy.select(&:even?).first(6).inspect
puts "Golden ratio: #{(fib_iterative(41).to_f / fib_iterative(40)).round(12)}"
