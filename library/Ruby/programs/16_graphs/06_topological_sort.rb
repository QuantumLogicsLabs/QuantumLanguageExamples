# Kahn's algorithm for a build order.
DEPS = {
  "app" => %w[ui api], "ui" => %w[components styles], "api" => %w[db auth],
  "auth" => %w[db crypto], "components" => %w[styles], "db" => [], "crypto" => [], "styles" => []
}.freeze

def topo_order(deps)
  indegree = deps.keys.to_h { |k| [k, deps[k].size] }
  users = Hash.new { |h, k| h[k] = [] }
  deps.each { |pkg, ds| ds.each { |d| users[d] << pkg } }
  ready = indegree.select { |_, d| d.zero? }.keys.sort
  order = []
  until ready.empty?
    pkg = ready.shift
    order << pkg
    users[pkg].each do |u|
      indegree[u] -= 1
      ready = (ready << u).sort if indegree[u].zero?
    end
  end
  order.size == deps.size ? order : nil
end

order = topo_order(DEPS)
puts order.join(" -> ")
puts order.each_with_index.all? { |pkg, i| DEPS[pkg].all? { |d| order.index(d) < i } }
cyclic = DEPS.merge("db" => %w[app])
puts topo_order(cyclic).inspect
