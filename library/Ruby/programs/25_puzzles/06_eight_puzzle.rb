# Solving the 8-puzzle with A* and the Manhattan distance.
GOAL = [1, 2, 3, 4, 5, 6, 7, 8, 0].freeze

def manhattan(state) = state.each_with_index.sum { |v, i| v.zero? ? 0 : ((v - 1) / 3 - i / 3).abs + ((v - 1) % 3 - i % 3).abs }

def neighbors(state)
  z = state.index(0)
  r, c = z.divmod(3)
  [[-1, 0, "down"], [1, 0, "up"], [0, -1, "right"], [0, 1, "left"]].filter_map do |dr, dc, name|
    nr, nc = r + dr, c + dc
    next unless nr.between?(0, 2) && nc.between?(0, 2)
    s = state.dup
    s[z], s[nr * 3 + nc] = s[nr * 3 + nc], s[z]
    [s, "#{s[z]} #{name}"]
  end
end

def solve(start)
  g = { start => 0 }
  prev = { start => nil }
  open = [start]
  until open.empty?
    cur = open.min_by { |s| [g[s] + manhattan(s), s] }
    open.delete(cur)
    if cur == GOAL
      moves = []
      moves.unshift(prev[cur][1]) && cur = prev[cur][0] while prev[cur]
      return moves
    end
    neighbors(cur).each do |s, move|
      next if g.key?(s) && g[s] <= g[cur] + 1
      g[s] = g[cur] + 1
      prev[s] = [cur, move]
      open << s
    end
  end
end

# A position is solvable only if its tiles have an even number of inversions
def solvable?(state) = state.reject(&:zero?).combination(2).count { |a, b| a > b }.even?

[[1, 2, 3, 4, 0, 6, 7, 5, 8], [1, 3, 6, 5, 0, 2, 4, 7, 8], [2, 8, 3, 1, 6, 4, 7, 0, 5]].each do |start|
  if solvable?(start)
    moves = solve(start)
    puts "#{start.inspect}: #{moves.size} moves: #{moves.join(', ')}"
  else
    puts "#{start.inspect}: unsolvable (odd number of inversions)"
  end
end
