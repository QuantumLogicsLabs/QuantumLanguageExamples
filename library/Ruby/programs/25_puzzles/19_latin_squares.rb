# Building and checking Latin squares.
def cyclic_latin(n) = Array.new(n) { |r| Array.new(n) { |c| (r + c) % n + 1 } }

def latin?(sq)
  n = sq.size
  target = (1..n).to_a
  sq.all? { |row| row.sort == target } && sq.transpose.all? { |col| col.sort == target }
end

def count_latin(n)
  sq = Array.new(n) { Array.new(n, 0) }
  count = 0
  fill = lambda do |i|
    if i == n * n
      count += 1
      return
    end
    r, c = i.divmod(n)
    (1..n).each do |v|
      next if sq[r].include?(v) || sq.any? { |row| row[c] == v }
      sq[r][c] = v
      fill.(i + 1)
      sq[r][c] = 0
    end
  end
  fill.(0)
  count
end

sq = cyclic_latin(5)
sq.each { |row| puts row.join(" ") }
puts latin?(sq)
broken = sq.map(&:dup)
broken[0][0], broken[0][1] = broken[0][1], broken[0][0]
puts latin?(broken)
(1..4).each { |n| puts "#{n}x#{n} Latin squares: #{count_latin(n)}" }
