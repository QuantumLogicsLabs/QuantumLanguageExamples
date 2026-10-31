# Fundamental solutions of Pell's equation x^2 - n*y^2 = 1.
def pell(n)
  a0 = Integer.sqrt(n)
  return nil if a0 * a0 == n
  m, d, a = 0, 1, a0
  h1, h, k1, k = 1, a0, 0, 1
  until h * h - n * k * k == 1
    m = d * a - m
    d = (n - m * m) / d
    a = (a0 + m) / d
    h1, h = h, a * h + h1
    k1, k = k, a * k + k1
  end
  [h, k]
end

[2, 3, 5, 7, 13, 29, 61, 9].each do |n|
  sol = pell(n)
  puts sol ? "n=#{n.to_s.rjust(2)}: x=#{sol[0]}, y=#{sol[1]}" : "n=#{n}: perfect square, no solution"
end
x, y = pell(2)
more = [[x, y]]
3.times { a, b = more.last; more << [a * x + 2 * b * y, a * y + b * x] }
puts "more solutions for n=2: #{more.inspect}"
