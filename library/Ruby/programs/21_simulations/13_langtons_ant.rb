# Langton's ant on a small wrapping grid.
size = 11
grid = Array.new(size) { Array.new(size, false) }
r = c = size / 2
dir = 0
moves = [[-1, 0], [0, 1], [1, 0], [0, -1]]

300.times do
  dir = grid[r][c] ? (dir + 3) % 4 : (dir + 1) % 4
  grid[r][c] = !grid[r][c]
  r = (r + moves[dir][0]) % size
  c = (c + moves[dir][1]) % size
end

grid.each_with_index do |row, y|
  puts row.each_with_index.map { |black, x| [y, x] == [r, c] ? "A" : black ? "#" : "." }.join
end
puts "black cells: #{grid.flatten.count(true)}, ant at #{[r, c].inspect} facing #{%w[N E S W][dir]}"
