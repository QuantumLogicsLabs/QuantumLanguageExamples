# Tracking visited grid positions with a Set of arrays.
moves = "RRUULDDDLLUUURR".chars
pos = [0, 0]
visited = Set[pos.dup]
revisits = []
deltas = { "R" => [1, 0], "L" => [-1, 0], "U" => [0, 1], "D" => [0, -1] }

moves.each do |m|
  dx, dy = deltas[m]
  pos = [pos[0] + dx, pos[1] + dy]
  revisits << pos.dup unless visited.add?(pos.dup)
end

puts "Final position: #{pos.inspect}"
puts "Distinct cells: #{visited.size}"
puts "Revisited: #{revisits.inspect}"
xs = visited.map(&:first)
ys = visited.map(&:last)
ys.max.downto(ys.min) do |y|
  puts (xs.min..xs.max).map { |x| [x, y] == [0, 0] ? "S" : visited.include?([x, y]) ? "#" : "." }.join
end
