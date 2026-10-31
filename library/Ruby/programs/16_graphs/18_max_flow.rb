# Maximum flow with Edmonds-Karp.
def max_flow(cap, s, t)
  n = cap.size
  flow = Array.new(n) { Array.new(n, 0) }
  total = 0
  loop do
    parent = Array.new(n)
    parent[s] = s
    queue = [s]
    until queue.empty? || parent[t]
      u = queue.shift
      n.times do |v|
        if parent[v].nil? && cap[u][v] - flow[u][v] > 0
          parent[v] = u
          queue << v
        end
      end
    end
    break unless parent[t]
    bottleneck = Float::INFINITY
    v = t
    while v != s
      u = parent[v]
      bottleneck = [bottleneck, cap[u][v] - flow[u][v]].min
      v = u
    end
    v = t
    while v != s
      u = parent[v]
      flow[u][v] += bottleneck
      flow[v][u] -= bottleneck
      v = u
    end
    total += bottleneck
    puts "augment by #{bottleneck}"
  end
  total
end

capacity = [
  [0, 16, 13, 0, 0, 0],
  [0, 0, 10, 12, 0, 0],
  [0, 4, 0, 0, 14, 0],
  [0, 0, 9, 0, 0, 20],
  [0, 0, 0, 7, 0, 4],
  [0, 0, 0, 0, 0, 0]
]
puts "max flow: #{max_flow(capacity, 0, 5)}"
