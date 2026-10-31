# Bridges and articulation points (Tarjan's low-link).
edges = [[0, 1], [1, 2], [2, 0], [1, 3], [3, 4], [4, 5], [5, 3], [5, 6], [7, 8]]
adj = Hash.new { |h, k| h[k] = [] }
edges.each { |a, b| adj[a] << b; adj[b] << a }

disc = {}
low = {}
time = 0
bridges = []
points = []

dfs = lambda do |u, parent|
  disc[u] = low[u] = (time += 1)
  children = 0
  cut = false
  adj[u].each do |v|
    next if v == parent
    if disc.key?(v)
      low[u] = [low[u], disc[v]].min
    else
      children += 1
      dfs.(v, u)
      low[u] = [low[u], low[v]].min
      bridges << [u, v].sort if low[v] > disc[u]
      cut = true if parent && low[v] >= disc[u]
    end
  end
  points << u if cut || (parent.nil? && children > 1)
end

adj.keys.sort.each { |u| dfs.(u, nil) unless disc.key?(u) }
puts "bridges: #{bridges.sort.inspect}"
puts "articulation points: #{points.sort.inspect}"
