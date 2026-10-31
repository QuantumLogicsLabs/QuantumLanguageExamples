# An Ulam spiral marking primes.
def prime?(n) = n > 1 && (2..Integer.sqrt(n)).none? { |d| (n % d).zero? }

size = 15
grid = Array.new(size) { Array.new(size, 0) }
x = y = size / 2
n = 1
grid[y][x] = n
step = 1
dirs = [[1, 0], [0, -1], [-1, 0], [0, 1]]
d = 0
while n < size * size
  2.times do
    step.times do
      break if n >= size * size
      x += dirs[d][0]
      y += dirs[d][1]
      n += 1
      grid[y][x] = n if y.between?(0, size - 1) && x.between?(0, size - 1)
    end
    d = (d + 1) % 4
  end
  step += 1
end

grid.each { |row| puts row.map { |v| v == 1 ? "1" : prime?(v) ? "#" : "." }.join(" ") }
diag = (0...size).map { |i| grid[i][i] }
puts "primes on the main diagonal: #{diag.count { |v| prime?(v) }}"
