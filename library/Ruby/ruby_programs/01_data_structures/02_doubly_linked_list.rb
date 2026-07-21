# Doubly Linked List supporting O(1) push/pop from both ends and
# forward/reverse iteration.
class DNode
  attr_accessor :value, :prev_node, :next_node
  def initialize(value)
    @value = value
  end
end

class DoublyLinkedList
  include Enumerable

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def push_back(value)
    node = DNode.new(value)
    if @tail
      @tail.next_node = node
      node.prev_node = @tail
      @tail = node
    else
      @head = @tail = node
    end
    @size += 1
    self
  end

  def push_front(value)
    node = DNode.new(value)
    if @head
      @head.prev_node = node
      node.next_node = @head
      @head = node
    else
      @head = @tail = node
    end
    @size += 1
    self
  end

  def pop_back
    return nil unless @tail
    val = @tail.value
    @tail = @tail.prev_node
    @tail ? @tail.next_node = nil : @head = nil
    @size -= 1
    val
  end

  def each
    return enum_for(:each) unless block_given?
    node = @head
    while node
      yield node.value
      node = node.next_node
    end
  end

  def each_reverse
    return enum_for(:each_reverse) unless block_given?
    node = @tail
    while node
      yield node.value
      node = node.prev_node
    end
  end

  def size
    @size
  end
end

if __FILE__ == $0
  dll = DoublyLinkedList.new
  dll.push_back(1).push_back(2).push_back(3)
  dll.push_front(0)
  puts "Forward: #{dll.to_a}"
  puts "Reverse: #{dll.each_reverse.to_a}"
  puts "Popped: #{dll.pop_back}"
  puts "After pop: #{dll.to_a}, size=#{dll.size}"
end
