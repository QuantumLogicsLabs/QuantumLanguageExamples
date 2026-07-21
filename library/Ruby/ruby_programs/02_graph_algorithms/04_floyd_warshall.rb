# Floyd-Warshall all-pairs shortest path via dynamic programming
# over an adjacency matrix. O(V^3), works with negative edges
# (but not negative cycles).
INF = Float::INFINITY

def floyd_warshall(matrix)
  n = matrix.size
  dist = matrix.map(&:dup)

  (0...n).each do |k|
    (0...n).each do |i|
      (0...n).each do |j|
        if dist[i][k] + dist[k][j] < dist[i][j]
          dist[i][j] = dist[i][k] + dist[k][j]
        end
      end
    end
  end
  dist
end

if __FILE__ == $0
  # 0: A, 1: B, 2: C, 3: D
  graph = [
    [0,   3,   INF, 7],
    [8,   0,   2,   INF],
    [5,   INF, 0,   1],
    [2,   INF, INF, 0],
  ]
  result = floyd_warshall(graph)
  labels = %w[A B C D]
  puts "All-pairs shortest paths:"
  result.each_with_index do |row, i|
    row.each_with_index do |d, j|
      next if i == j
      puts "  #{labels[i]} -> #{labels[j]}: #{d == INF ? 'unreachable' : d}"
    end
  end
end
