# A robot following commands on a grid with obstacles.
class Robot
  HEADINGS = %w[N E S W].freeze
  STEP = { "N" => [0, 1], "E" => [1, 0], "S" => [0, -1], "W" => [-1, 0] }.freeze

  attr_reader :x, :y, :heading, :trail

  def initialize(obstacles)
    @x = @y = 0
    @heading = "N"
    @obstacles = obstacles
    @trail = [[0, 0]]
  end

  def run(commands)
    commands.scan(/[LR]|F\d*/).each do |cmd|
      case cmd
      when "L" then turn(-1)
      when "R" then turn(1)
      else forward(cmd[1..].to_s.empty? ? 1 : cmd[1..].to_i)
      end
    end
    self
  end

  def to_s = "at (#{x}, #{y}) facing #{heading}"

  private

  def turn(d) = @heading = HEADINGS[(HEADINGS.index(@heading) + d) % 4]

  def forward(n)
    dx, dy = STEP[@heading]
    n.times do
      nxt = [@x + dx, @y + dy]
      return if @obstacles.include?(nxt)
      @x, @y = nxt
      @trail << nxt
    end
  end
end

robot = Robot.new([[2, 4], [-1, 3]])
puts robot.run("F3RF2LF5LLF2RF4")
puts "visited #{robot.trail.uniq.size} cells, farthest #{robot.trail.map { |a, b| a.abs + b.abs }.max} from start"
