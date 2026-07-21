# Tarjan's algorithm for finding Strongly Connected Components in a
# directed graph using a single DFS pass with low-link values.
class TarjanSCC
  def initialize(num_vertices, edges)
    @adj = Hash.new { |h, k| h[k] = [] }
    edges.each { |u, v| @adj[u] << v }
    @n = num_vertices
    @index_counter = 0
    @index = {}
    @lowlink = {}
    @on_stack = {}
    @stack = []
    @sccs = []
  end

  def run
    (0...@n).each { |v| strong_connect(v) unless @index[v] }
    @sccs
  end

  private

  def strong_connect(v)
    @index[v] = @index_counter
    @lowlink[v] = @index_counter
    @index_counter += 1
    @stack.push(v)
    @on_stack[v] = true

    @adj[v].each do |w|
      if !@index[w]
        strong_connect(w)
        @lowlink[v] = [@lowlink[v], @lowlink[w]].min
      elsif @on_stack[w]
        @lowlink[v] = [@lowlink[v], @index[w]].min
      end
    end

    if @lowlink[v] == @index[v]
      scc = []
      loop do
        w = @stack.pop
        @on_stack[w] = false
        scc << w
        break if w == v
      end
      @sccs << scc
    end
  end
end

if __FILE__ == $0
  edges = [[0, 1], [1, 2], [2, 0], [1, 3], [3, 4], [4, 5], [5, 3]]
  sccs = TarjanSCC.new(6, edges).run
  puts "Strongly connected components: #{sccs}"
end
