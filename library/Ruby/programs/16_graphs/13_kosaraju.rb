# Strongly connected components with Kosaraju's algorithm.
graph = {
  a: [:b], b: [:c, :e, :f], c: [:d, :g], d: [:c, :h], e: [:a, :f], f: [:g], g: [:f], h: [:d, :g]
}

order = []
seen = {}
visit = ->(u) do
  seen[u] = true
  graph[u].each { |v| visit.(v) unless seen[v] }
  order << u
end
graph.keys.each { |u| visit.(u) unless seen[u] }

reversed = Hash.new { |h, k| h[k] = [] }
graph.each { |u, vs| vs.each { |v| reversed[v] << u } }

seen = {}
components = []
order.reverse_each do |u|
  next if seen[u]
  comp = []
  stack = [u]
  until stack.empty?
    x = stack.pop
    next if seen[x]
    seen[x] = true
    comp << x
    stack.concat(reversed[x])
  end
  components << comp.sort
end
components.each { |c| puts c.inspect }
puts "#{components.size} components"
