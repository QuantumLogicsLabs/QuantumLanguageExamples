# Detecting cycles in directed graphs with three colours.
def find_cycle(graph)
  color = Hash.new(:white)
  stack = []
  visit = lambda do |u|
    color[u] = :gray
    stack.push(u)
    graph.fetch(u, []).each do |v|
      return stack[stack.index(v)..] + [v] if color[v] == :gray
      if color[v] == :white
        found = visit.(v)
        return found if found
      end
    end
    stack.pop
    color[u] = :black
    nil
  end
  graph.keys.each do |u|
    next unless color[u] == :white
    found = visit.(u)
    return found if found
  end
  nil
end

graphs = {
  "acyclic" => { a: [:b, :c], b: [:d], c: [:d], d: [] },
  "loop" => { a: [:b], b: [:c], c: [:d], d: [:b] },
  "self" => { x: [:x] },
  "two parts" => { p: [:q], q: [], r: [:s], s: [:t], t: [:r] }
}
graphs.each { |name, g| puts "#{name.ljust(10)} #{(c = find_cycle(g)) ? c.join(' -> ') : 'no cycle'}" }
