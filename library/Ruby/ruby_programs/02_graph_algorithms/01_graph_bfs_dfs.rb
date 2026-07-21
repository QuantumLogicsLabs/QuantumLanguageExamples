# Adjacency-list Graph with breadth-first and depth-first traversal.
class Graph
  def initialize
    @adj = Hash.new { |h, k| h[k] = [] }
  end

  def add_edge(u, v, directed: false)
    @adj[u] << v
    @adj[v] << u unless directed
    self
  end

  def bfs(start)
    visited = { start => true }
    queue = [start]
    order = []
    until queue.empty?
      node = queue.shift
      order << node
      @adj[node].each do |neighbor|
        unless visited[neighbor]
          visited[neighbor] = true
          queue << neighbor
        end
      end
    end
    order
  end

  def dfs(start)
    visited = {}
    order = []
    dfs_visit(start, visited, order)
    order
  end

  private

  def dfs_visit(node, visited, order)
    return if visited[node]
    visited[node] = true
    order << node
    @adj[node].each { |neighbor| dfs_visit(neighbor, visited, order) }
  end
end

if __FILE__ == $0
  g = Graph.new
  [[1, 2], [1, 3], [2, 4], [3, 4], [4, 5]].each { |u, v| g.add_edge(u, v) }
  puts "BFS from 1: #{g.bfs(1)}"
  puts "DFS from 1: #{g.dfs(1)}"
end
