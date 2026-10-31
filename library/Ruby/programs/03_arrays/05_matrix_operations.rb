# Matrices as arrays of arrays.
a = [[1, 2, 3], [4, 5, 6]]
b = [[7, 8], [9, 10], [11, 12]]

def show(name, m)
  puts "#{name}:"
  m.each { |row| puts "  " + row.map { |x| x.to_s.rjust(4) }.join }
end

def multiply(x, y)
  x.map { |row| y.transpose.map { |col| row.zip(col).sum { |p, q| p * q } } }
end

show("A", a)
show("A transposed", a.transpose)
show("B", b)
show("A x B", multiply(a, b))
identity = Array.new(3) { |i| Array.new(3) { |j| i == j ? 1 : 0 } }
show("I", identity)
show("B^T x I", multiply(b.transpose, identity))
puts "Trace of A x B: #{multiply(a, b).each_with_index.sum { |row, i| row[i] }}"
