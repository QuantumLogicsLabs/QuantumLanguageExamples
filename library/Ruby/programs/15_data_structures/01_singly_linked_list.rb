# A singly linked list with common operations.
class LinkedList
  include Enumerable
  Node = Struct.new(:value, :next_node)

  def initialize(*values)
    @head = nil
    @size = 0
    values.each { |v| append(v) }
  end

  attr_reader :size

  def append(value)
    node = Node.new(value, nil)
    if @head
      tail = @head
      tail = tail.next_node while tail.next_node
      tail.next_node = node
    else
      @head = node
    end
    @size += 1
    self
  end

  def prepend(value)
    @head = Node.new(value, @head)
    @size += 1
    self
  end

  def each
    node = @head
    while node
      yield node.value
      node = node.next_node
    end
  end

  def reverse!
    prev = nil
    node = @head
    while node
      node.next_node, prev, node = prev, node, node.next_node
    end
    @head = prev
    self
  end

  def delete(value)
    return if @head.nil?
    if @head.value == value
      @head = @head.next_node
      @size -= 1
      return value
    end
    node = @head
    node = node.next_node while node.next_node && node.next_node.value != value
    return nil unless node.next_node
    node.next_node = node.next_node.next_node
    @size -= 1
    value
  end

  def middle = to_a[size / 2]
  def to_s = to_a.join(" -> ")
end

list = LinkedList.new(1, 2, 3, 4)
list.append(5).prepend(0)
puts list
puts "size #{list.size}, middle #{list.middle}, sum #{list.sum}"
list.delete(3)
puts list
puts list.reverse!
puts list.select(&:even?).inspect
puts list.delete(42).inspect
