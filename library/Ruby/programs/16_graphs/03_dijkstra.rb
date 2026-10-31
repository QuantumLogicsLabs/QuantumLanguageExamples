# Dijkstra's algorithm on a weighted road map.
ROADS = [
  ["Amsterdam", "Utrecht", 45], ["Amsterdam", "Haarlem", 20], ["Haarlem", "Leiden", 33],
  ["Leiden", "TheHague", 18], ["Utrecht", "Rotterdam", 60], ["TheHague", "Rotterdam", 25],
  ["Utrecht", "Arnhem", 65], ["Rotterdam", "Breda", 52], ["Arnhem", "Breda", 120], ["Amsterdam", "Leiden", 45]
].freeze

graph = Hash.new { |h, k| h[k] = [] }
ROADS.each { |a, b, km| graph[a] << [b, km]; graph[b] << [a, km] }

def dijkstra(graph, source)
  dist = Hash.new(Float::INFINITY)
  prev = {}
  dist[source] = 0
  pending = graph.keys
  until pending.empty?
    u = pending.min_by { |n| dist[n] }
    pending.delete(u)
    graph[u].each do |v, w|
      next unless dist[u] + w < dist[v]
      dist[v] = dist[u] + w
      prev[v] = u
    end
  end
  [dist, prev]
end

dist, prev = dijkstra(graph, "Amsterdam")
dist.sort_by { |_, d| d }.each do |city, d|
  path = [city]
  path.unshift(prev[path.first]) while prev[path.first]
  puts "#{city.ljust(10)} #{d.to_s.rjust(4)} km  #{path.join(' > ')}"
end
