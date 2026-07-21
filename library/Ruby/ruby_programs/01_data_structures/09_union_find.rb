# Disjoint Set (Union-Find) with path compression and union by rank,
# giving near-O(1) amortized find/union operations.
class UnionFind
  def initialize(n)
    @parent = Array.new(n) { |i| i }
    @rank = Array.new(n, 0)
    @count = n
  end

  def find(x)
    while @parent[x] != x
      @parent[x] = @parent[@parent[x]] # path compression (halving)
      x = @parent[x]
    end
    x
  end

  def union(x, y)
    root_x, root_y = find(x), find(y)
    return false if root_x == root_y

    root_x, root_y = root_y, root_x if @rank[root_x] < @rank[root_y]
    @parent[root_y] = root_x
    @rank[root_x] += 1 if @rank[root_x] == @rank[root_y]
    @count -= 1
    true
  end

  def connected?(x, y)
    find(x) == find(y)
  end

  def component_count
    @count
  end
end

if __FILE__ == $0
  uf = UnionFind.new(10)
  [[0, 1], [1, 2], [3, 4], [5, 6], [6, 7]].each { |a, b| uf.union(a, b) }
  puts "0 and 2 connected? #{uf.connected?(0, 2)}"
  puts "0 and 3 connected? #{uf.connected?(0, 3)}"
  puts "Number of components: #{uf.component_count}"
  uf.union(2, 3)
  puts "After union(2,3), 0 and 4 connected? #{uf.connected?(0, 4)}"
  puts "Number of components: #{uf.component_count}"
end
