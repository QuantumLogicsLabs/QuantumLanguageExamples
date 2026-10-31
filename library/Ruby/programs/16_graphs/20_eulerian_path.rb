# Hierholzer's algorithm for an Eulerian path.
def eulerian_path(edges)
  adj = Hash.new { |h, k| h[k] = [] }
  degree = Hash.new(0)
  edges.each do |a, b|
    adj[a] << b
    degree[a] += 1
    degree[b] -= 1
  end
  adj.each_value(&:sort!)
  start = degree.find { |_, d| d == 1 }&.first || edges.first[0]
  stack = [start]
  path = []
  until stack.empty?
    v = stack.last
    if adj[v].empty?
      path << stack.pop
    else
      stack << adj[v].shift
    end
  end
  path.reverse
end

tickets = [%w[JFK SFO], %w[JFK ATL], %w[SFO ATL], %w[ATL JFK], %w[ATL SFO]]
puts eulerian_path(tickets).join(" -> ")
domino = [[1, 2], [2, 3], [3, 1], [1, 4], [4, 5], [5, 1]]
puts eulerian_path(domino).join(" -> ")
