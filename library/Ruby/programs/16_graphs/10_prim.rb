# Prim's algorithm growing a spanning tree from one vertex.
graph = {
  0 => { 1 => 2, 3 => 6 }, 1 => { 0 => 2, 2 => 3, 3 => 8, 4 => 5 },
  2 => { 1 => 3, 4 => 7 }, 3 => { 0 => 6, 1 => 8, 4 => 9 }, 4 => { 1 => 5, 2 => 7, 3 => 9 }
}

in_tree = [0]
total = 0
until in_tree.size == graph.size
  candidates = in_tree.flat_map { |u| graph[u].reject { |v, _| in_tree.include?(v) }.map { |v, w| [w, u, v] } }
  w, u, v = candidates.min
  in_tree << v
  total += w
  puts "add edge #{u}-#{v} weight #{w}"
end
puts "total #{total}, order #{in_tree.inspect}"
