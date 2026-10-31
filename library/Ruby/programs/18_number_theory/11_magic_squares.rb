# Odd-order magic squares by the Siamese method.
def magic_square(n)
  sq = Array.new(n) { Array.new(n, 0) }
  r, c = 0, n / 2
  (1..n * n).each do |k|
    sq[r][c] = k
    nr, nc = (r - 1) % n, (c + 1) % n
    if sq[nr][nc].zero?
      r, c = nr, nc
    else
      r = (r + 1) % n
    end
  end
  sq
end

def magic?(sq)
  n = sq.size
  target = n * (n * n + 1) / 2
  lines = sq + sq.transpose + [(0...n).map { |i| sq[i][i] }, (0...n).map { |i| sq[i][n - 1 - i] }]
  lines.all? { |l| l.sum == target }
end

[3, 5].each do |n|
  sq = magic_square(n)
  sq.each { |row| puts row.map { |v| v.to_s.rjust(3) }.join }
  puts "magic constant #{n * (n * n + 1) / 2}, valid #{magic?(sq)}"
end
puts magic?([[1, 2], [3, 4]])
