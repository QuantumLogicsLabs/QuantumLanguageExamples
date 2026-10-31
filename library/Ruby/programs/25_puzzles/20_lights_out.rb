# Lights Out on a 3x3 board, solved by trying all press patterns.
SIZE = 3

def press(board, r, c)
  b = board.map(&:dup)
  [[0, 0], [1, 0], [-1, 0], [0, 1], [0, -1]].each do |dr, dc|
    y, x = r + dr, c + dc
    b[y][x] ^= 1 if y.between?(0, SIZE - 1) && x.between?(0, SIZE - 1)
  end
  b
end

def solve(board)
  cells = (0...SIZE * SIZE).map { |i| i.divmod(SIZE) }
  (0...2**cells.size).map { |mask| cells.select.with_index { |_, i| mask[i] == 1 } }
                     .sort_by(&:size)
                     .find { |presses| presses.reduce(board) { |b, (r, c)| press(b, r, c) }.flatten.all?(&:zero?) }
end

def show(b) = b.map { |row| row.map { |v| v == 1 ? "#" : "." }.join }.join(" / ")

[[[1, 0, 1], [0, 1, 0], [1, 0, 1]], [[1, 1, 0], [1, 0, 0], [0, 0, 0]], [[0, 1, 0], [1, 1, 1], [0, 1, 0]]].each do |board|
  presses = solve(board)
  puts "#{show(board)}: press #{presses.inspect} (#{presses.size} presses)"
  final = presses.reduce(board) { |b, (r, c)| press(b, r, c) }
  puts "  result #{show(final)}"
end
