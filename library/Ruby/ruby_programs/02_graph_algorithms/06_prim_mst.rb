# Prim's Minimum Spanning Tree: grow a tree from an arbitrary root,
# always adding the cheapest edge that connects a new vertex.
def prim(num_vertices, adj)
  # adj: hash of vertex => [[neighbor, weight], ...]
  visited = Array.new(num_vertices, false)
  min_edge = Array.new(num_vertices, Float::INFINITY)
  parent = Array.new(num_vertices, -1)
  min_edge[0] = 0
  total_weight = 0
  mst_edges = []

  num_vertices.times do
    u = -1
    (0...num_vertices).each do |v|
      next if visited[v]
      u = v if u == -1 || min_edge[v] < min_edge[u]
    end
    break if min_edge[u] == Float::INFINITY

    visited[u] = true
    total_weight += min_edge[u]
    mst_edges << [parent[u], u, min_edge[u]] if parent[u] != -1

    adj[u].each do |v, weight|
      if !visited[v] && weight < min_edge[v]
        min_edge[v] = weight
        parent[v] = u
      end
    end
  end
  [mst_edges, total_weight]
end

if __FILE__ == $0
  adj = Hash.new { |h, k| h[k] = [] }
  raw = [[0, 1, 4], [0, 7, 8], [1, 2, 8], [1, 7, 11], [2, 3, 7], [2, 8, 2], [2, 5, 4],
         [3, 4, 9], [3, 5, 14], [4, 5, 10], [5, 6, 2], [6, 7, 1], [6, 8, 6], [7, 8, 7]]
  raw.each { |u, v, w| adj[u] << [v, w]; adj[v] << [u, w] }
  mst, weight = prim(9, adj)
  puts "MST edges:"
  mst.each { |u, v, w| puts "  #{u} -- #{v} (weight #{w})" }
  puts "Total weight: #{weight}"
end
