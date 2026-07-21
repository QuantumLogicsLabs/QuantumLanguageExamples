# Singly Linked List with common operations: push, delete, reverse,
# find middle (Floyd's slow/fast pointer), and cycle detection.
class Node
  attr_accessor :value, :next_node
  def initialize(value)
    @value = value
    @next_node = nil
  end
end

class LinkedList
  include Enumerable
  attr_reader :head

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def push(value)
    node = Node.new(value)
    if @head.nil?
      @head = @tail = node
    else
      @tail.next_node = node
      @tail = node
    end
    @size += 1
    self
  end
  alias_method :<<, :push

  def each
    return enum_for(:each) unless block_given?
    node = @head
    while node
      yield node.value
      node = node.next_node
    end
  end

  def delete(value)
    return false if @head.nil?
    if @head.value == value
      @head = @head.next_node
      @size -= 1
      return true
    end
    prev = @head
    curr = @head.next_node
    while curr
      if curr.value == value
        prev.next_node = curr.next_node
        @tail = prev if curr == @tail
        @size -= 1
        return true
      end
      prev = curr
      curr = curr.next_node
    end
    false
  end

  def reverse!
    prev = nil
    curr = @head
    @tail = @head
    while curr
      nxt = curr.next_node
      curr.next_node = prev
      prev = curr
      curr = nxt
    end
    @head = prev
    self
  end

  def middle
    slow = fast = @head
    while fast && fast.next_node
      slow = slow.next_node
      fast = fast.next_node.next_node
    end
    slow&.value
  end

  def has_cycle?
    slow = fast = @head
    while fast && fast.next_node
      slow = slow.next_node
      fast = fast.next_node.next_node
      return true if slow == fast
    end
    false
  end

  def size
    @size
  end
end

if __FILE__ == $0
  list = LinkedList.new
  [1, 2, 3, 4, 5].each { |v| list << v }
  puts "List: #{list.to_a}"
  puts "Middle element: #{list.middle}"
  list.delete(3)
  puts "After deleting 3: #{list.to_a}"
  list.reverse!
  puts "Reversed: #{list.to_a}"
  puts "Has cycle? #{list.has_cycle?}"
  puts "Size: #{list.size}"
end
