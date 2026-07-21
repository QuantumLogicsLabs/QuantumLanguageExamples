# Dijkstra's single-source shortest path algorithm on a weighted graph.
# Uses a simple array-based priority queue -- fine for teaching-scale
# graphs; swap in a binary heap for production-scale performance.
require 'set'

class WeightedGraph
  def initialize
    @adj = Hash.new { |h, k| h[k] = [] }
  end

  def add_edge(u, v, weight)
    @adj[u] << [v, weight]
    @adj[v] << [u, weight]
    self
  end

  def dijkstra(source)
    dist = Hash.new(Float::INFINITY)
    dist[source] = 0
    visited = Set.new
    pq = [[0, source]]

    until pq.empty?
      pq.sort_by! { |d, _| d }
      d, u = pq.shift
      next if visited.include?(u)
      visited << u

      @adj[u].each do |v, weight|
        next if visited.include?(v)
        new_dist = d + weight
        if new_dist < dist[v]
          dist[v] = new_dist
          pq << [new_dist, v]
        end
      end
    end
    dist
  end
end

if __FILE__ == $0
  g = WeightedGraph.new
  g.add_edge('A', 'B', 4)
  g.add_edge('A', 'C', 1)
  g.add_edge('C', 'B', 2)
  g.add_edge('B', 'D', 5)
  g.add_edge('C', 'D', 8)
  dist = g.dijkstra('A')
  dist.sort.each { |node, d| puts "A -> #{node}: #{d}" }
end
