# Four people crossing a bridge at night with one torch (shortest time by Dijkstra).
TIMES = { "A" => 1, "B" => 2, "C" => 5, "D" => 10 }.freeze
START = [TIMES.keys.sort, :left].freeze

def moves(state)
  left, side = state
  right = TIMES.keys - left
  here = side == :left ? left : right
  groups = side == :left ? here.combination(2).to_a + here.combination(1).to_a : here.combination(1).to_a
  groups.map do |g|
    new_left = side == :left ? left - g : (left + g).sort
    [[new_left, side == :left ? :right : :left], g.map { |p| TIMES[p] }.max, g]
  end
end

dist = { START => 0 }
prev = {}
pending = [START]
until pending.empty?
  cur = pending.min_by { |s| [dist[s], s.inspect] }
  pending.delete(cur)
  break if cur[0].empty?
  moves(cur).each do |nxt, cost, group|
    next if dist.key?(nxt) && dist[nxt] <= dist[cur] + cost
    dist[nxt] = dist[cur] + cost
    prev[nxt] = [cur, group]
    pending << nxt
  end
end

goal = dist.keys.find { |s| s[0].empty? }
steps = []
s = goal
while prev[s]
  before, group = prev[s]
  steps.unshift("#{group.join('+')} #{before[1] == :left ? 'cross' : 'return'} (#{group.map { |p| TIMES[p] }.max} min)")
  s = before
end
puts steps
puts "total: #{dist[goal]} minutes"
