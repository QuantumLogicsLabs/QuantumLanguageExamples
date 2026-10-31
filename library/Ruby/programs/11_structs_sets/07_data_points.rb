# Data value objects as hash keys and in sets.
Cell = Data.define(:row, :col) do
  def neighbors = [[-1, 0], [1, 0], [0, -1], [0, 1]].map { |dr, dc| Cell.new(row + dr, col + dc) }
  def to_s = "(#{row},#{col})"
end

walls = Set[Cell.new(1, 1), Cell.new(1, 2), Cell.new(2, 1)]
start = Cell.new(0, 0)
seen = Set[start]
frontier = [start]
3.times do
  frontier = frontier.flat_map(&:neighbors).uniq.select do |c|
    c.row.between?(0, 3) && c.col.between?(0, 3) && !walls.include?(c) && !seen.include?(c)
  end
  seen.merge(frontier)
  puts "reached: #{frontier.map(&:to_s).sort.join(' ')}"
end
puts "visited #{seen.size} cells"
distances = { Cell.new(0, 0) => 0, Cell.new(3, 3) => 6 }
puts distances[Cell.new(3, 3)]
