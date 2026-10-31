# All-pairs shortest paths with Floyd-Warshall.
INF = Float::INFINITY
names = %w[A B C D]
w = [
  [0, 3, INF, 7],
  [8, 0, 2, INF],
  [5, INF, 0, 1],
  [2, INF, INF, 0]
]
n = w.size
dist = w.map(&:dup)
nxt = Array.new(n) { |i| Array.new(n) { |j| w[i][j] < INF ? j : nil } }

n.times do |k|
  n.times do |i|
    n.times do |j|
      next unless dist[i][k] + dist[k][j] < dist[i][j]
      dist[i][j] = dist[i][k] + dist[k][j]
      nxt[i][j] = nxt[i][k]
    end
  end
end

puts "    " + names.map { |s| s.rjust(4) }.join
dist.each_with_index { |row, i| puts names[i].ljust(4) + row.map { |d| d.to_s.rjust(4) }.join }

def route(nxt, names, i, j)
  path = [i]
  path << (i = nxt[i][j]) while i != j
  path.map { |x| names[x] }.join("->")
end
puts route(nxt, names, 1, 3)
puts route(nxt, names, 3, 2)
