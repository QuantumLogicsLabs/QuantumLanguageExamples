# Kruskal's minimum spanning tree with union-find.
edges = [
  ["A", "B", 7], ["A", "D", 5], ["B", "C", 8], ["B", "D", 9], ["B", "E", 7], ["C", "E", 5],
  ["D", "E", 15], ["D", "F", 6], ["E", "F", 8], ["E", "G", 9], ["F", "G", 11]
]

parent = {}
find = ->(x) { parent[x] == x ? x : (parent[x] = find.(parent[x])) }
edges.flat_map { |a, b, _| [a, b] }.uniq.each { |v| parent[v] = v }

tree = []
edges.sort_by { |a, b, w| [w, a, b] }.each do |a, b, w|
  ra, rb = find.(a), find.(b)
  next if ra == rb
  parent[ra] = rb
  tree << [a, b, w]
  puts "take #{a}-#{b} (#{w})"
end
puts "MST weight: #{tree.sum(&:last)}, edges: #{tree.size}"
