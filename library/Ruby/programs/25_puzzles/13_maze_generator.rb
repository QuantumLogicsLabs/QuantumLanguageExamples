# Generating a maze with a deterministic recursive backtracker.
class Lcg
  def initialize(seed) = @s = seed
  def rand(n) = (@s = (@s * 1_103_515_245 + 12_345) % 2**31) % n
end

W, H = 8, 5
rng = Lcg.new(2024)
walls_east = Array.new(H) { Array.new(W, true) }
walls_south = Array.new(H) { Array.new(W, true) }
visited = Array.new(H) { Array.new(W, false) }
stack = [[0, 0]]
visited[0][0] = true

until stack.empty?
  r, c = stack.last
  options = [[r - 1, c], [r + 1, c], [r, c - 1], [r, c + 1]].select { |y, x| y.between?(0, H - 1) && x.between?(0, W - 1) && !visited[y][x] }
  if options.empty?
    stack.pop
    next
  end
  nr, nc = options[rng.rand(options.size)]
  if nr == r then walls_east[r][[c, nc].min] = false
  else walls_south[[r, nr].min][c] = false
  end
  visited[nr][nc] = true
  stack << [nr, nc]
end

puts "+" + "---+" * W
H.times do |r|
  puts "|" + W.times.map { |c| "   " + (walls_east[r][c] ? "|" : " ") }.join
  puts "+" + W.times.map { |c| walls_south[r][c] ? "---+" : "   +" }.join
end
open_walls = walls_east.flatten.count(false) + walls_south.flatten.count(false)
puts "passages: #{open_walls} (a perfect maze has #{W * H - 1})"
