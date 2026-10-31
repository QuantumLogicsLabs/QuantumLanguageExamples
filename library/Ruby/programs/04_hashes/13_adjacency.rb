# An undirected graph as a hash of neighbour lists.
edges = [%w[A B], %w[A C], %w[B C], %w[B D], %w[C E], %w[D E], %w[E F]]

graph = Hash.new { |h, k| h[k] = [] }
edges.each do |a, b|
  graph[a] << b
  graph[b] << a
end

graph.sort.each { |node, nbrs| puts "#{node}: #{nbrs.sort.join(' ')} (degree #{nbrs.size})" }
puts "Edges: #{graph.values.sum(&:size) / 2}"
hub = graph.max_by { |node, nbrs| [nbrs.size, node] }
puts "Busiest node: #{hub[0]}"
leaves = graph.select { |_, n| n.size == 1 }.keys
puts "Leaves: #{leaves.inspect}"
common = graph["B"] & graph["E"]
puts "Common neighbours of B and E: #{common.sort.inspect}"
