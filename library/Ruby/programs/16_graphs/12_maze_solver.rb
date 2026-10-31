# Solving a text maze with BFS and drawing the path.
MAZE = <<~M.lines.map { |l| l.chomp.chars }
  ##########
  #S   #   #
  # ## # # #
  #  #   # #
  ## ##### #
  #      # #
  # #### # #
  #    #  E#
  ##########
M

start = goal = nil
MAZE.each_with_index { |row, r| row.each_with_index { |ch, c| start = [r, c] if ch == "S"; goal = [r, c] if ch == "E" } }

prev = { start => nil }
queue = [start]
until queue.empty?
  cur = queue.shift
  break if cur == goal
  r, c = cur
  [[r + 1, c], [r - 1, c], [r, c + 1], [r, c - 1]].each do |nr, nc|
    next if MAZE[nr][nc] == "#" || prev.key?([nr, nc])
    prev[[nr, nc]] = cur
    queue << [nr, nc]
  end
end

path = []
node = goal
while node
  path << node
  node = prev[node]
end
path.each { |r, c| MAZE[r][c] = "." unless %w[S E].include?(MAZE[r][c]) }
puts MAZE.map(&:join)
puts "Path length: #{path.size - 1}, cells explored: #{prev.size}"
