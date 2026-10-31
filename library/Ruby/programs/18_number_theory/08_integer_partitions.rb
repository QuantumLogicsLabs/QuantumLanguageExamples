# Counting and listing integer partitions.
def partition_count(n)
  ways = Array.new(n + 1, 0)
  ways[0] = 1
  (1..n).each { |part| (part..n).each { |s| ways[s] += ways[s - part] } }
  ways[n]
end

def partitions(n, max = n)
  return [[]] if n.zero?
  [max, n].min.downto(1).flat_map { |first| partitions(n - first, first).map { |rest| [first] + rest } }
end

partitions(6).each { |p| puts p.join(" + ") }
puts (1..20).map { |n| partition_count(n) }.inspect
puts "p(100) = #{partition_count(100)}"
distinct = partitions(10).count { |p| p.uniq.size == p.size }
odd = partitions(10).count { |p| p.all?(&:odd?) }
puts "10 into distinct parts: #{distinct}, into odd parts: #{odd}"
