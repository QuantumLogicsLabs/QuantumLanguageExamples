# Tic-tac-toe with two perfect minimax players.
LINES = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze

def winner(b) = LINES.map { |l| l.map { |i| b[i] }.uniq }.find { |v| v.size == 1 && v[0] != " " }&.first

def minimax(board, player, memo = {})
  key = board.join + player
  return memo[key] if memo.key?(key)
  w = winner(board)
  return memo[key] = [w == "X" ? 1 : -1, nil] if w
  moves = board.each_index.select { |i| board[i] == " " }
  return memo[key] = [0, nil] if moves.empty?
  results = moves.map do |m|
    board[m] = player
    score, = minimax(board, player == "X" ? "O" : "X", memo)
    board[m] = " "
    [score, m]
  end
  memo[key] = player == "X" ? results.max_by { |s, m| [s, -m] } : results.min_by { |s, m| [s, m] }
end

def show(b) = b.each_slice(3).map { |r| r.join("|") }.join("\n-+-+-\n")

board = Array.new(9, " ")
board[0] = "X"
player = "O"
until winner(board) || !board.include?(" ")
  _, move = minimax(board, player)
  board[move] = player
  player = player == "X" ? "O" : "X"
end
puts show(board)
puts "result: #{winner(board) || 'draw'}"
puts "value of the empty board for X: #{minimax(Array.new(9, ' '), 'X').first}"
