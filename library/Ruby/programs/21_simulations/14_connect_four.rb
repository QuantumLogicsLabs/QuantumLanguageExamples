# Connect Four with scripted moves and win detection.
ROWS = 6
COLS = 7

def drop(board, col, piece)
  row = (ROWS - 1).downto(0).find { |r| board[r][col] == "." }
  return nil unless row
  board[row][col] = piece
  row
end

def wins?(board, r, c)
  piece = board[r][c]
  [[0, 1], [1, 0], [1, 1], [1, -1]].any? do |dr, dc|
    count = 1
    [1, -1].each do |sign|
      y, x = r + dr * sign, c + dc * sign
      while y.between?(0, ROWS - 1) && x.between?(0, COLS - 1) && board[y][x] == piece
        count += 1
        y += dr * sign
        x += dc * sign
      end
    end
    count >= 4
  end
end

board = Array.new(ROWS) { Array.new(COLS, ".") }
moves = [0, 1, 1, 2, 3, 2, 2, 3, 6, 3, 3]
players = %w[X O]
moves.each_with_index do |col, i|
  piece = players[i % 2]
  row = drop(board, col, piece)
  if wins?(board, row, col)
    puts "#{piece} wins with move #{i + 1} in column #{col}"
    break
  end
end
board.each { |row| puts row.join(" ") }
puts (0...COLS).to_a.join(" ")
