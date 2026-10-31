# Missionaries and cannibals: three of each must cross with a two-seat boat.
START = [3, 3, :left].freeze
GOAL = [0, 0, :right].freeze
LOADS = [[1, 0], [2, 0], [0, 1], [0, 2], [1, 1]].freeze

def safe?(m, c) = [m, c].all? { |x| x.between?(0, 3) } && (m.zero? || m >= c) && (3 - m).then { |mo| mo.zero? || mo >= 3 - c }

prev = { START => nil }
queue = [START]
until queue.empty?
  state = queue.shift
  break if state == GOAL
  m, c, side = state
  dir = side == :left ? -1 : 1
  LOADS.each do |dm, dc|
    nm, nc = m + dir * dm, c + dir * dc
    nxt = [nm, nc, side == :left ? :right : :left]
    next unless safe?(nm, nc) && !prev.key?(nxt)
    prev[nxt] = [state, [dm, dc]]
    queue << nxt
  end
end

steps = []
s = GOAL
while prev[s]
  before, (dm, dc) = prev[s]
  steps.unshift("#{'M' * dm}#{'C' * dc} cross #{before[2] == :left ? '->' : '<-'}  left bank: #{s[0]}M #{s[1]}C")
  s = before
end
puts steps
puts "#{steps.size} crossings"
