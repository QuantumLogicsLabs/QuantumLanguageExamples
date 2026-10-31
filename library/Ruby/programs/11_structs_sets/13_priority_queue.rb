# A binary heap priority queue holding tasks.
Task = Struct.new(:priority, :name)

class PriorityQueue
  def initialize = @heap = []
  def size = @heap.size
  def empty? = @heap.empty?

  def push(item)
    @heap << item
    i = @heap.size - 1
    while i.positive? && (@heap[(i - 1) / 2].priority > @heap[i].priority)
      parent = (i - 1) / 2
      @heap[i], @heap[parent] = @heap[parent], @heap[i]
      i = parent
    end
    self
  end

  def pop
    return nil if empty?
    top = @heap[0]
    last = @heap.pop
    unless empty?
      @heap[0] = last
      i = 0
      loop do
        l, r = 2 * i + 1, 2 * i + 2
        smallest = i
        smallest = l if l < size && @heap[l].priority < @heap[smallest].priority
        smallest = r if r < size && @heap[r].priority < @heap[smallest].priority
        break if smallest == i
        @heap[i], @heap[smallest] = @heap[smallest], @heap[i]
        i = smallest
      end
    end
    top
  end
end

pq = PriorityQueue.new
[[5, "write docs"], [1, "fix outage"], [3, "review PR"], [4, "lunch"], [2, "deploy"], [1, "call boss"]].each do |p, n|
  pq.push(Task.new(p, n))
end
puts "#{pq.size} tasks"
puts "#{pq.pop.then { |t| "#{t.priority}: #{t.name}" }}" until pq.empty?
