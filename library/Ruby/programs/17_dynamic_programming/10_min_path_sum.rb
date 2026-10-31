# Minimum path sum through a grid, moving right or down.
grid = [
  [1, 3, 1, 8],
  [1, 5, 1, 2],
  [4, 2, 1, 9],
  [7, 1, 3, 1]
]

rows, cols = grid.size, grid[0].size
best = Array.new(rows) { Array.new(cols) }
rows.times do |r|
  cols.times do |c|
    up = r.positive? ? best[r - 1][c] : nil
    left = c.positive? ? best[r][c - 1] : nil
    best[r][c] = grid[r][c] + ([up, left].compact.min || 0)
  end
end

path = []
r, c = rows - 1, cols - 1
loop do
  path.unshift([r, c])
  break if r.zero? && c.zero?
  if r.zero? then c -= 1
  elsif c.zero? then r -= 1
  else best[r - 1][c] <= best[r][c - 1] ? r -= 1 : c -= 1
  end
end
puts "minimum sum: #{best[-1][-1]}"
puts "path: #{path.map { |y, x| grid[y][x] }.join(' + ')}"
grid.each_with_index { |row, y| puts row.each_with_index.map { |v, x| path.include?([y, x]) ? "[#{v}]" : " #{v} " }.join }
