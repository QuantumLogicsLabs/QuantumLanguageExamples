# Anonymous recursion with the Y (Z) combinator.
Z = ->(f) { ->(x) { x.(x) }.(->(x) { f.(->(v) { x.(x).(v) }) }) }

factorial = Z.(->(self_fn) { ->(n) { n.zero? ? 1 : n * self_fn.(n - 1) } })
fibonacci = Z.(->(self_fn) { ->(n) { n < 2 ? n : self_fn.(n - 1) + self_fn.(n - 2) } })
sum_digits = Z.(->(self_fn) { ->(n) { n < 10 ? n : n % 10 + self_fn.(n / 10) } })

puts (0..10).map(&factorial).inspect
puts (0..15).map(&fibonacci).inspect
puts sum_digits.(987654321)

memo_fix = ->(f) do
  cache = {}
  rec = ->(n) { cache.fetch(n) { cache[n] = f.(rec).(n) } }
end
fast_fib = memo_fix.(->(self_fn) { ->(n) { n < 2 ? n : self_fn.(n - 1) + self_fn.(n - 2) } })
puts fast_fib.(90)
