# Counting lattice paths around obstacles.
def paths(grid)
  rows, cols = grid.size, grid[0].size
  dp = Array.new(rows) { Array.new(cols, 0) }
  rows.times do |r|
    cols.times do |c|
      next if grid[r][c] == "#"
      dp[r][c] = r.zero? && c.zero? ? 1 : (r.positive? ? dp[r - 1][c] : 0) + (c.positive? ? dp[r][c - 1] : 0)
    end
  end
  dp
end

open = Array.new(4) { "." * 5 }
puts "4x5 open grid: #{paths(open).last.last}"
blocked = ["....", ".#..", "...#", "#..."]
table = paths(blocked)
table.each { |row| puts row.map { |v| v.to_s.rjust(3) }.join }
puts "with obstacles: #{table.last.last}"
puts "binomial check 10x10: #{paths(Array.new(10) { '.' * 10 }).last.last} vs #{(1..18).reduce(:*) / ((1..9).reduce(:*)**2)}"
