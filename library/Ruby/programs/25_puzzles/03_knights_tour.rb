# A knight's tour using Warnsdorff's heuristic.
N = 6
MOVES = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]].freeze

def onward(board, r, c)
  MOVES.map { |dr, dc| [r + dr, c + dc] }.select { |y, x| y.between?(0, N - 1) && x.between?(0, N - 1) && board[y][x].zero? }
end

board = Array.new(N) { Array.new(N, 0) }
r, c = 0, 0
board[r][c] = 1
(2..N * N).each do |step|
  options = onward(board, r, c)
  break if options.empty?
  r, c = options.min_by { |y, x| [onward(board, y, x).size, y, x] }
  board[r][c] = step
end

board.each { |row| puts row.map { |v| v.to_s.rjust(3) }.join }
visited = board.flatten.count(&:positive?)
puts "visited #{visited} of #{N * N} squares"
ok = (1...visited).all? do |k|
  a = board.flatten.index(k).divmod(N)
  b = board.flatten.index(k + 1).divmod(N)
  [(a[0] - b[0]).abs, (a[1] - b[1]).abs].sort == [1, 2]
end
puts "every step is a knight move: #{ok}"
