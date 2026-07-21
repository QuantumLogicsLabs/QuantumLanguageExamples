# A* pathfinding on a grid using Manhattan distance as the heuristic --
# combines Dijkstra's guarantees with heuristic-guided search speed.
def astar(grid, start, goal)
  rows, cols = grid.size, grid[0].size
  heuristic = ->(a, b) { (a[0] - b[0]).abs + (a[1] - b[1]).abs }

  open_set = [start]
  came_from = {}
  g_score = Hash.new(Float::INFINITY)
  g_score[start] = 0
  f_score = Hash.new(Float::INFINITY)
  f_score[start] = heuristic.call(start, goal)

  until open_set.empty?
    current = open_set.min_by { |node| f_score[node] }
    return reconstruct_path(came_from, current) if current == goal

    open_set.delete(current)
    neighbors(current, rows, cols).each do |neighbor|
      next if grid[neighbor[0]][neighbor[1]] == 1 # wall
      tentative_g = g_score[current] + 1
      if tentative_g < g_score[neighbor]
        came_from[neighbor] = current
        g_score[neighbor] = tentative_g
        f_score[neighbor] = tentative_g + heuristic.call(neighbor, goal)
        open_set << neighbor unless open_set.include?(neighbor)
      end
    end
  end
  nil # no path found
end

def neighbors(node, rows, cols)
  r, c = node
  [[r - 1, c], [r + 1, c], [r, c - 1], [r, c + 1]].select do |nr, nc|
    nr.between?(0, rows - 1) && nc.between?(0, cols - 1)
  end
end

def reconstruct_path(came_from, current)
  path = [current]
  path.unshift(current = came_from[current]) while came_from[current]
  path
end

if __FILE__ == $0
  grid = [
    [0, 0, 0, 0, 0],
    [0, 1, 1, 1, 0],
    [0, 0, 0, 1, 0],
    [1, 1, 0, 1, 0],
    [0, 0, 0, 0, 0],
  ]
  path = astar(grid, [0, 0], [4, 4])
  puts "Path from [0,0] to [4,4]: #{path}"
end
