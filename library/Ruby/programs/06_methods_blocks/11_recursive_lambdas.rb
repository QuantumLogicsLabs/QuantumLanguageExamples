# Recursion with lambdas and methods.
fact = ->(n) { n <= 1 ? 1 : n * fact.(n - 1) }
puts (0..10).map(&fact).inspect

ackermann = lambda do |m, n|
  if m.zero? then n + 1
  elsif n.zero? then ackermann.(m - 1, 1)
  else ackermann.(m - 1, ackermann.(m, n - 1))
  end
end
puts (0..3).map { |m| (0..3).map { |n| ackermann.(m, n) } }.inspect

flatten = ->(arr) { arr.flat_map { |e| e.is_a?(Array) ? flatten.(e) : [e] } }
puts flatten.([1, [2, [3, [4, [5]]]], 6]).inspect

hanoi_moves = ->(n, from, to, via) do
  n.zero? ? [] : hanoi_moves.(n - 1, from, via, to) + [[from, to]] + hanoi_moves.(n - 1, via, to, from)
end
moves = hanoi_moves.(3, "A", "C", "B")
puts "#{moves.size} moves: #{moves.map { |a, b| "#{a}#{b}" }.join(' ')}"
