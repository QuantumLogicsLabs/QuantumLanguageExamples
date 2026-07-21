# Bellman-Ford: handles negative edge weights and detects
# negative-weight cycles, unlike Dijkstra.
class BellmanFord
  Edge = Struct.new(:from, :to, :weight)

  def initialize(vertices)
    @vertices = vertices
    @edges = []
  end

  def add_edge(from, to, weight)
    @edges << Edge.new(from, to, weight)
    self
  end

  def shortest_paths(source)
    dist = Hash.new(Float::INFINITY)
    dist[source] = 0

    (@vertices.size - 1).times do
      @edges.each do |e|
        if dist[e.from] + e.weight < dist[e.to]
          dist[e.to] = dist[e.from] + e.weight
        end
      end
    end

    @edges.each do |e|
      if dist[e.from] + e.weight < dist[e.to]
        return { error: "Graph contains a negative-weight cycle" }
      end
    end

    dist
  end
end

if __FILE__ == $0
  bf = BellmanFord.new(%w[A B C D E])
  bf.add_edge('A', 'B', -1)
  bf.add_edge('A', 'C', 4)
  bf.add_edge('B', 'C', 3)
  bf.add_edge('B', 'D', 2)
  bf.add_edge('B', 'E', 2)
  bf.add_edge('D', 'B', 1)
  bf.add_edge('D', 'C', 5)
  bf.add_edge('E', 'D', -3)
  result = bf.shortest_paths('A')
  if result[:error]
    puts result[:error]
  else
    result.sort.each { |node, d| puts "A -> #{node}: #{d}" }
  end
end
