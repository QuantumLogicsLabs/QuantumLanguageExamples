# Cycle detection for both directed graphs (via a 3-color/state DFS)
# and undirected graphs (via parent-tracking DFS).
def has_cycle_directed?(num_vertices, edges)
  adj = Hash.new { |h, k| h[k] = [] }
  edges.each { |u, v| adj[u] << v }
  state = Array.new(num_vertices, 0) # 0=unvisited, 1=in-progress, 2=done

  visit = lambda do |u|
    state[u] = 1
    adj[u].each do |v|
      return true if state[v] == 1
      return true if state[v] == 0 && visit.call(v)
    end
    state[u] = 2
    false
  end

  (0...num_vertices).any? { |v| state[v] == 0 && visit.call(v) }
end

def has_cycle_undirected?(num_vertices, edges)
  adj = Hash.new { |h, k| h[k] = [] }
  edges.each { |u, v| adj[u] << v; adj[v] << u }
  visited = Array.new(num_vertices, false)

  visit = lambda do |u, parent|
    visited[u] = true
    adj[u].each do |v|
      next if v == parent
      return true if visited[v] || visit.call(v, u)
    end
    false
  end

  (0...num_vertices).any? { |v| !visited[v] && visit.call(v, -1) }
end

if __FILE__ == $0
  puts "Directed cycle [0->1,1->2,2->0]: #{has_cycle_directed?(3, [[0, 1], [1, 2], [2, 0]])}"
  puts "Directed no cycle [0->1,1->2]: #{has_cycle_directed?(3, [[0, 1], [1, 2]])}"
  puts "Undirected cycle [0-1,1-2,2-0]: #{has_cycle_undirected?(3, [[0, 1], [1, 2], [2, 0]])}"
  puts "Undirected tree [0-1,1-2]: #{has_cycle_undirected?(3, [[0, 1], [1, 2]])}"
end
