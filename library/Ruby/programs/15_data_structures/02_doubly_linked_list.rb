# A doubly linked list with insertion and removal at both ends.
class DList
  Node = Struct.new(:value, :prev, :nxt)
  attr_reader :size

  def initialize
    @head = @tail = nil
    @size = 0
  end

  def push(v)
    node = Node.new(v, @tail, nil)
    @tail ? @tail.nxt = node : @head = node
    @tail = node
    @size += 1
    self
  end

  def unshift(v)
    node = Node.new(v, nil, @head)
    @head ? @head.prev = node : @tail = node
    @head = node
    @size += 1
    self
  end

  def pop
    return nil unless @tail
    node = @tail
    @tail = node.prev
    @tail ? @tail.nxt = nil : @head = nil
    @size -= 1
    node.value
  end

  def shift
    return nil unless @head
    node = @head
    @head = node.nxt
    @head ? @head.prev = nil : @tail = nil
    @size -= 1
    node.value
  end

  def forward = walk(@head, :nxt)
  def backward = walk(@tail, :prev)

  private

  def walk(node, dir)
    out = []
    while node
      out << node.value
      node = node.public_send(dir)
    end
    out
  end
end

d = DList.new
d.push(2).push(3).unshift(1).push(4)
puts d.forward.inspect
puts d.backward.inspect
puts d.pop, d.shift
puts d.forward.inspect, d.size
d.pop
d.pop
puts d.pop.inspect, d.forward.inspect
