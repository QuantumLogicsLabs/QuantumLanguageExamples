# A backtracking Sudoku solver.
PUZZLE = <<~S
  53..7....
  6..195...
  .98....6.
  8...6...3
  4..8.3..1
  7...2...6
  .6....28.
  ...419..5
  ....8..79
S

grid = PUZZLE.lines.map { |l| l.chomp.chars.map { |c| c == "." ? 0 : c.to_i } }

def candidates(g, r, c)
  used = g[r] + g.map { |row| row[c] } + g[r / 3 * 3, 3].flat_map { |row| row[c / 3 * 3, 3] }
  (1..9).to_a - used
end

def solve(g, stats)
  empties = (0...81).map { |i| i.divmod(9) }.select { |r, c| g[r][c].zero? }
  return true if empties.empty?
  r, c = empties.min_by { |rr, cc| candidates(g, rr, cc).size }
  candidates(g, r, c).each do |v|
    stats[:tries] += 1
    g[r][c] = v
    return true if solve(g, stats)
  end
  g[r][c] = 0
  false
end

stats = { tries: 0 }
puts solve(grid, stats)
grid.each_with_index do |row, i|
  puts "------+-------+------" if i.positive? && (i % 3).zero?
  puts row.each_slice(3).map { |s| s.join(" ") }.join(" | ")
end
puts "placements tried: #{stats[:tries]}"
