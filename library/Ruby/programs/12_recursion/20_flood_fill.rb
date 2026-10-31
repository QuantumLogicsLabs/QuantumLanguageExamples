# Recursive flood fill on a character grid.
grid = [
  "##########",
  "#....#...#",
  "#.##.#.#.#",
  "#.#..#.#.#",
  "#.####.#.#",
  "#......#.#",
  "##########"
].map(&:chars)

def fill(grid, r, c, from, to)
  return 0 unless r.between?(0, grid.size - 1) && c.between?(0, grid[0].size - 1)
  return 0 unless grid[r][c] == from
  grid[r][c] = to
  1 + fill(grid, r + 1, c, from, to) + fill(grid, r - 1, c, from, to) +
    fill(grid, r, c + 1, from, to) + fill(grid, r, c - 1, from, to)
end

regions = 0
sizes = []
grid.each_index do |r|
  grid[r].each_index do |c|
    next unless grid[r][c] == "."
    regions += 1
    sizes << fill(grid, r, c, ".", (96 + regions).chr)
  end
end
grid.each { |row| puts row.join }
puts "Regions: #{regions}, sizes #{sizes.inspect}"
