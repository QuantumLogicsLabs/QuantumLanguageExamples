# Breadth-first search for shortest paths in an unweighted graph.
GRAPH = {
  "A" => %w[B C], "B" => %w[A D E], "C" => %w[A F], "D" => %w[B],
  "E" => %w[B F G], "F" => %w[C E H], "G" => %w[E H], "H" => %w[F G], "Z" => []
}.freeze

def bfs_path(start, goal)
  prev = { start => nil }
  queue = [start]
  until queue.empty?
    node = queue.shift
    break if node == goal
    GRAPH[node].each do |n|
      next if prev.key?(n)
      prev[n] = node
      queue << n
    end
  end
  return nil unless prev.key?(goal)
  path = [goal]
  path.unshift(prev[path.first]) while prev[path.first]
  path
end

def distances(start)
  dist = { start => 0 }
  queue = [start]
  until queue.empty?
    node = queue.shift
    GRAPH[node].each { |n| next if dist.key?(n); dist[n] = dist[node] + 1; queue << n }
  end
  dist
end

[%w[A H], %w[D G], %w[A A], %w[A Z]].each do |s, g|
  path = bfs_path(s, g)
  puts "#{s} -> #{g}: #{path ? "#{path.join(' -> ')} (#{path.size - 1} edges)" : 'unreachable'}"
end
puts distances("A").sort.inspect
