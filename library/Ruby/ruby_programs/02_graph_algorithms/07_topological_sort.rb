# Topological sort of a DAG via two classic methods: Kahn's algorithm
# (BFS on in-degrees) and a DFS-based post-order approach.
def topo_sort_kahn(num_vertices, edges)
  adj = Hash.new { |h, k| h[k] = [] }
  in_degree = Array.new(num_vertices, 0)
  edges.each do |u, v|
    adj[u] << v
    in_degree[v] += 1
  end

  queue = (0...num_vertices).select { |v| in_degree[v].zero? }
  order = []
  until queue.empty?
    u = queue.shift
    order << u
    adj[u].each do |v|
      in_degree[v] -= 1
      queue << v if in_degree[v].zero?
    end
  end

  raise "Graph has a cycle" if order.size != num_vertices
  order
end

def topo_sort_dfs(num_vertices, edges)
  adj = Hash.new { |h, k| h[k] = [] }
  edges.each { |u, v| adj[u] << v }
  visited = Array.new(num_vertices, false)
  stack = []

  visit = lambda do |u|
    visited[u] = true
    adj[u].each { |v| visit.call(v) unless visited[v] }
    stack.push(u)
  end

  (0...num_vertices).each { |v| visit.call(v) unless visited[v] }
  stack.reverse
end

if __FILE__ == $0
  edges = [[5, 2], [5, 0], [4, 0], [4, 1], [2, 3], [3, 1]]
  puts "Kahn's topological order: #{topo_sort_kahn(6, edges)}"
  puts "DFS-based topological order: #{topo_sort_dfs(6, edges)}"
end
