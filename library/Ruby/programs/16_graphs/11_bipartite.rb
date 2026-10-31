# Two-colouring graphs to test whether they are bipartite.
def bipartite(adj)
  color = {}
  adj.keys.each do |start|
    next if color.key?(start)
    color[start] = 0
    queue = [start]
    until queue.empty?
      u = queue.shift
      adj[u].each do |v|
        if !color.key?(v)
          color[v] = 1 - color[u]
          queue << v
        elsif color[v] == color[u]
          return [false, [u, v]]
        end
      end
    end
  end
  [true, color.group_by { |_, c| c }.transform_values { |ps| ps.map(&:first).sort }]
end

square = { 1 => [2, 4], 2 => [1, 3], 3 => [2, 4], 4 => [3, 1] }
triangle = { 1 => [2, 3], 2 => [1, 3], 3 => [1, 2] }
students = { "ana" => %w[bo], "bo" => %w[ana cy], "cy" => %w[bo dee], "dee" => %w[cy] }
[square, triangle, students].each do |g|
  ok, info = bipartite(g)
  puts ok ? "bipartite: #{info.inspect}" : "not bipartite (conflict on edge #{info.inspect})"
end
