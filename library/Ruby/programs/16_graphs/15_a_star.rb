# A* search on a weighted grid with a Manhattan heuristic.
GRID = [
  "S.....#...",
  ".####.#.#.",
  ".#....#.#.",
  ".#.####.#.",
  "...#....#G",
  ".#...##...",
].map(&:chars)

def find(ch) = GRID.each_with_index { |row, r| c = row.index(ch); return [r, c] if c }

start, goal = find("S"), find("G")
h = ->(p) { (p[0] - goal[0]).abs + (p[1] - goal[1]).abs }
g = { start => 0 }
came = {}
open = [start]
expanded = 0
until open.empty?
  cur = open.min_by { |p| [g[p] + h.(p), h.(p), p] }
  break if cur == goal
  open.delete(cur)
  expanded += 1
  r, c = cur
  [[r + 1, c], [r - 1, c], [r, c + 1], [r, c - 1]].each do |n|
    next unless n[0].between?(0, GRID.size - 1) && n[1].between?(0, GRID[0].size - 1)
    next if GRID[n[0]][n[1]] == "#"
    cost = g[cur] + 1
    next if g.key?(n) && g[n] <= cost
    g[n] = cost
    came[n] = cur
    open << n unless open.include?(n)
  end
end

node = came[goal]
while node && node != start
  GRID[node[0]][node[1]] = "*"
  node = came[node]
end
puts GRID.map(&:join)
puts "cost #{g[goal]}, expanded #{expanded} nodes"
