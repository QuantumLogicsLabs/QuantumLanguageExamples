# Finding dictionary words in a Boggle board.
BOARD = %w[RUBY ATEN LOSD EXIM].map(&:chars)
DICT = %w[RUBY RAT RATE TEN TENS LOSE NOSE DIME MIX TAN BAT RUBE BURN SET LEX TONE SEND MIND STONE ATE].freeze

def find?(word)
  4.times do |r|
    4.times do |c|
      return true if dfs(word, 0, r, c, {})
    end
  end
  false
end

def dfs(word, i, r, c, seen)
  return false unless r.between?(0, 3) && c.between?(0, 3)
  return false if seen[[r, c]] || BOARD[r][c] != word[i]
  return true if i == word.size - 1
  seen[[r, c]] = true
  found = [-1, 0, 1].product([-1, 0, 1]).any? { |dr, dc| !(dr.zero? && dc.zero?) && dfs(word, i + 1, r + dr, c + dc, seen) }
  seen.delete([r, c])
  found
end

BOARD.each { |row| puts row.join(" ") }
found = DICT.select { |w| find?(w) }
puts "found: #{found.sort.inspect}"
puts "missing: #{(DICT - found).sort.inspect}"
score = found.sum { |w| { 3 => 1, 4 => 1, 5 => 2 }.fetch(w.size, 3) }
puts "score: #{score}"
