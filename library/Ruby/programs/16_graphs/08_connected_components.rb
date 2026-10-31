# Connected components of an undirected graph.
edges = [[1, 2], [2, 3], [4, 5], [6, 7], [7, 8], [8, 6], [9, 9], [3, 1], [10, 11]]
nodes = (1..12).to_a

adj = Hash.new { |h, k| h[k] = [] }
edges.each { |a, b| adj[a] << b; adj[b] << a }

seen = {}
components = []
nodes.each do |start|
  next if seen[start]
  comp = []
  stack = [start]
  until stack.empty?
    n = stack.pop
    next if seen[n]
    seen[n] = true
    comp << n
    stack.concat(adj[n])
  end
  components << comp.sort
end

components.each_with_index { |c, i| puts "component #{i + 1}: #{c.inspect}" }
puts "count: #{components.size}, largest: #{components.max_by(&:size).inspect}"
puts "isolated: #{components.select { |c| c.size == 1 && adj[c[0]].empty? }.flatten.inspect}"
