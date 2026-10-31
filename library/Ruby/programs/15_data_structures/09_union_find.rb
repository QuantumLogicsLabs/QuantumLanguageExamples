# Disjoint sets with union by rank and path compression.
class UnionFind
  def initialize(n)
    @parent = (0...n).to_a
    @rank = Array.new(n, 0)
    @sets = n
  end

  attr_reader :sets

  def find(x)
    @parent[x] = find(@parent[x]) unless @parent[x] == x
    @parent[x]
  end

  def union(a, b)
    ra, rb = find(a), find(b)
    return false if ra == rb
    ra, rb = rb, ra if @rank[ra] < @rank[rb]
    @parent[rb] = ra
    @rank[ra] += 1 if @rank[ra] == @rank[rb]
    @sets -= 1
    true
  end

  def groups = (0...@parent.size).group_by { |x| find(x) }.values
end

uf = UnionFind.new(10)
[[0, 1], [2, 3], [1, 3], [5, 6], [7, 8], [8, 9], [0, 2], [6, 5]].each do |a, b|
  puts "union(#{a}, #{b}) -> #{uf.union(a, b)}, sets #{uf.sets}"
end
puts uf.groups.inspect
puts uf.find(3) == uf.find(0)
puts uf.find(4) == uf.find(5)
