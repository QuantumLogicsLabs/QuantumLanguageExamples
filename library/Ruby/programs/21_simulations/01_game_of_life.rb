# Conway's Game of Life on a wrapping board.
class Life
  attr_reader :cells

  def initialize(rows, cols, live)
    @rows, @cols = rows, cols
    @cells = Array.new(rows) { Array.new(cols, false) }
    live.each { |r, c| @cells[r][c] = true }
  end

  def neighbors(r, c)
    [-1, 0, 1].product([-1, 0, 1]).count do |dr, dc|
      !(dr.zero? && dc.zero?) && @cells[(r + dr) % @rows][(c + dc) % @cols]
    end
  end

  def step
    @cells = Array.new(@rows) do |r|
      Array.new(@cols) do |c|
        n = neighbors(r, c)
        n == 3 || (n == 2 && @cells[r][c])
      end
    end
    self
  end

  def population = @cells.flatten.count(true)
  def to_s = @cells.map { |row| row.map { |x| x ? "#" : "." }.join }.join("\n")
end

life = Life.new(8, 8, [[0, 1], [1, 2], [2, 0], [2, 1], [2, 2]])
done = 0
[0, 1, 4].each do |gen|
  (gen - done).times { life.step }
  done = gen
  puts "generation #{gen} (#{life.population} alive):"
  puts life
end
blinker = Life.new(5, 5, [[2, 1], [2, 2], [2, 3]])
puts blinker.step.to_s.lines[1..3].join
puts blinker.step.population
