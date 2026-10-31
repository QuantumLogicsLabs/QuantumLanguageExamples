# Depth-first search, recursive and with an explicit stack.
GRAPH = { 1 => [2, 3], 2 => [4, 5], 3 => [6], 4 => [], 5 => [6, 7], 6 => [], 7 => [1] }.freeze

def dfs_recursive(node, seen = [], &visit)
  return seen if seen.include?(node)
  seen << node
  visit&.call(node)
  GRAPH[node].each { |n| dfs_recursive(n, seen, &visit) }
  seen
end

def dfs_stack(start)
  seen = []
  stack = [start]
  until stack.empty?
    node = stack.pop
    next if seen.include?(node)
    seen << node
    GRAPH[node].reverse_each { |n| stack.push(n) unless seen.include?(n) }
  end
  seen
end

def all_paths(from, to, path = [from])
  return [path] if from == to
  GRAPH[from].reject { |n| path.include?(n) }.flat_map { |n| all_paths(n, to, path + [n]) }
end

puts dfs_recursive(1).inspect
puts dfs_stack(1).inspect
depths = []
dfs_recursive(1) { |n| depths << n * 10 }
puts depths.inspect
puts all_paths(1, 6).map { |p| p.join(">") }.inspect
