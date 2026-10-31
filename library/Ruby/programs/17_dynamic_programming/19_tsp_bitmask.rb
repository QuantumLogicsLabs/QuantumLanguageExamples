# The travelling salesman problem with bitmask DP.
CITIES = %w[Home Bakery Bank Post Gym].freeze
DIST = [
  [0, 12, 10, 19, 8],
  [12, 0, 3, 7, 2],
  [10, 3, 0, 6, 20],
  [19, 7, 6, 0, 4],
  [8, 2, 20, 4, 0]
].freeze

n = CITIES.size
full = (1 << n) - 1
best = Array.new(1 << n) { Array.new(n, Float::INFINITY) }
parent = Array.new(1 << n) { Array.new(n) }
best[1][0] = 0
(1..full).each do |mask|
  next if mask[0].zero?
  n.times do |last|
    next if mask[last].zero? || best[mask][last].infinite?
    n.times do |nxt|
      next unless mask[nxt].zero?
      nm = mask | (1 << nxt)
      cost = best[mask][last] + DIST[last][nxt]
      next unless cost < best[nm][nxt]
      best[nm][nxt] = cost
      parent[nm][nxt] = last
    end
  end
end

finish = (1...n).min_by { |c| best[full][c] + DIST[c][0] }
total = best[full][finish] + DIST[finish][0]
route = []
mask, cur = full, finish
while cur
  route.unshift(cur)
  prev = parent[mask][cur]
  mask ^= 1 << cur
  cur = prev
end
puts "shortest tour: #{(route + [0]).map { |i| CITIES[i] }.join(' -> ')} (#{total})"
brute = (1...n).to_a.permutation.map { |p| ([0] + p + [0]).each_cons(2).sum { |a, b| DIST[a][b] } }.min
puts "brute force agrees: #{brute == total}"
