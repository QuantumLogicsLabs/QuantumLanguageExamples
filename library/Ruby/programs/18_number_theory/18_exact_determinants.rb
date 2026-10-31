# Determinants and inverses with exact rational arithmetic.
def det(m)
  a = m.map { |row| row.map { |v| Rational(v) } }
  n = a.size
  sign = 1
  result = Rational(1)
  n.times do |col|
    pivot = (col...n).find { |r| !a[r][col].zero? }
    return 0 if pivot.nil?
    if pivot != col
      a[col], a[pivot] = a[pivot], a[col]
      sign = -sign
    end
    result *= a[col][col]
    (col + 1...n).each do |r|
      f = a[r][col] / a[col][col]
      (col...n).each { |c| a[r][c] -= f * a[col][c] }
    end
  end
  sign * result
end

def inverse(m)
  n = m.size
  a = m.each_with_index.map { |row, i| row.map { |v| Rational(v) } + Array.new(n) { |j| Rational(i == j ? 1 : 0) } }
  n.times do |col|
    pivot = (col...n).find { |r| !a[r][col].zero? } or return nil
    a[col], a[pivot] = a[pivot], a[col]
    p = a[col][col]
    a[col] = a[col].map { |v| v / p }
    n.times { |r| a[r] = a[r].zip(a[col]).map { |x, y| x - a[r][col] * y } unless r == col }
  end
  a.map { |row| row[n..] }
end

m = [[2, -1, 0], [-1, 2, -1], [0, -1, 2]]
puts det(m)
inverse(m).each { |row| puts row.map(&:to_s).join("  ") }
puts det([[1, 2], [2, 4]])
puts inverse([[1, 2], [2, 4]]).inspect
puts det([[0, 1, 2], [3, 4, 5], [6, 7, 9]])
hilbert = (1..4).map { |i| (1..4).map { |j| Rational(1, i + j - 1) } }
puts "det(Hilbert 4) = #{det(hilbert)}"
