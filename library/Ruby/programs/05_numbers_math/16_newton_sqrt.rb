# Square roots by Newton's method, integer and float.
def isqrt(n)
  return n if n < 2
  x = n
  y = (x + 1) / 2
  while y < x
    x = y
    y = (x + n / x) / 2
  end
  x
end

def newton_sqrt(v, tolerance = 1e-12)
  guess = v / 2.0
  iterations = 0
  loop do
    nxt = (guess + v / guess) / 2
    iterations += 1
    break [nxt, iterations] if (nxt - guess).abs < tolerance
    guess = nxt
  end
end

[2, 10, 144, 1_000_000, 10**20 + 1].each { |n| puts "isqrt(#{n}) = #{isqrt(n)} (Integer.sqrt #{Integer.sqrt(n)})" }
[2.0, 3.0, 50.0].each do |v|
  r, i = newton_sqrt(v)
  puts "sqrt(#{v}) ~ #{r.round(10)} after #{i} iterations (Math: #{Math.sqrt(v).round(10)})"
end
