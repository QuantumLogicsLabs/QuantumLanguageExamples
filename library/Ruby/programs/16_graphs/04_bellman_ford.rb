# Bellman-Ford with negative edges and cycle detection.
def bellman_ford(n, edges, source)
  dist = Array.new(n, Float::INFINITY)
  dist[source] = 0
  (n - 1).times do
    edges.each { |u, v, w| dist[v] = dist[u] + w if dist[u] + w < dist[v] }
  end
  cycle = edges.any? { |u, v, w| dist[u] + w < dist[v] }
  [dist, cycle]
end

edges = [[0, 1, 4], [0, 2, 5], [1, 2, -3], [2, 3, 4], [3, 1, 2], [1, 4, 6], [3, 4, -2]]
dist, cycle = bellman_ford(5, edges, 0)
puts "distances: #{dist.inspect}, negative cycle: #{cycle}"

bad = edges + [[4, 3, -1]]
dist2, cycle2 = bellman_ford(5, bad, 0)
puts "with 4->3 (-1): negative cycle: #{cycle2}"

rates = { %w[USD EUR] => 0.9, %w[EUR GBP] => 0.8, %w[GBP USD] => 1.45, %w[USD JPY] => 150.0, %w[JPY USD] => 0.0066 }
names = rates.keys.flatten.uniq
fx_edges = rates.map { |(a, b), r| [names.index(a), names.index(b), -Math.log(r)] }
_, arbitrage = bellman_ford(names.size, fx_edges, 0)
puts "currency arbitrage possible: #{arbitrage} (USD->EUR->GBP->USD = #{(0.9 * 0.8 * 1.45).round(4)})"
