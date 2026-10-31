# Custom sequences with Enumerator.new.
fib = Enumerator.new do |y|
  a, b = 0, 1
  loop do
    y << a
    a, b = b, a + b
  end
end

collatz = ->(n) do
  Enumerator.new do |y|
    loop do
      y << n
      break if n == 1
      n = n.even? ? n / 2 : 3 * n + 1
    end
  end
end

puts fib.take(10).inspect
puts fib.lazy.select(&:odd?).first(6).inspect
puts collatz.(6).to_a.inspect
puts collatz.(27).count
puts collatz.(27).max

alternating = Enumerator.new { |y| n = 1; loop { y.yield n; n = -(n + (n.positive? ? 1 : -1)) } }
puts alternating.take(8).inspect

chars = Enumerator.produce("a", &:succ)
puts chars.take(5).join
doubling = Enumerator.produce(1) { |x| x * 2 }
puts doubling.take_while { |x| x < 1000 }.inspect
