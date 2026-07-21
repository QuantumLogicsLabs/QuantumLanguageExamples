# Kruskal's Minimum Spanning Tree: sort edges by weight, greedily add
# edges that don't form a cycle (checked via Union-Find).
class UnionFindMST
  def initialize(n)
    @parent = Array.new(n) { |i| i }
  end

  def find(x)
    @parent[x] = find(@parent[x]) unless @parent[x] == x
    @parent[x]
  end

  def union(x, y)
    rx, ry = find(x), find(y)
    return false if rx == ry
    @parent[rx] = ry
    true
  end
end

def kruskal(num_vertices, edges)
  # edges: array of [weight, u, v]
  sorted = edges.sort_by { |w, _, _| w }
  uf = UnionFindMST.new(num_vertices)
  mst = []
  total_weight = 0

  sorted.each do |weight, u, v|
    if uf.union(u, v)
      mst << [u, v, weight]
      total_weight += weight
    end
  end
  [mst, total_weight]
end

if __FILE__ == $0
  edges = [
    [4, 0, 1], [8, 0, 7], [11, 1, 7], [8, 1, 2],
    [7, 2, 3], [2, 2, 5], [4, 2, 8], [14, 3, 4],
    [9, 3, 5], [10, 4, 5], [1, 5, 6], [7, 6, 7], [6, 6, 8], [2, 7, 8]
  ]
  mst, weight = kruskal(9, edges)
  puts "MST edges:"
  mst.each { |u, v, w| puts "  #{u} -- #{v} (weight #{w})" }
  puts "Total weight: #{weight}"
end
