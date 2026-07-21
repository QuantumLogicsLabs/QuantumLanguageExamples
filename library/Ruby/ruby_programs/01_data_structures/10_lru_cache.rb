# LRU (Least Recently Used) Cache combining a Hash for O(1) lookup with
# a doubly linked list for O(1) reordering/eviction on access.
class LRUCache
  Node = Struct.new(:key, :value, :prev_node, :next_node)

  def initialize(capacity)
    @capacity = capacity
    @map = {}
    @head = Node.new(:head, nil) # dummy head
    @tail = Node.new(:tail, nil) # dummy tail
    @head.next_node = @tail
    @tail.prev_node = @head
  end

  def get(key)
    node = @map[key]
    return -1 unless node
    move_to_front(node)
    node.value
  end

  def put(key, value)
    if (node = @map[key])
      node.value = value
      move_to_front(node)
    else
      node = Node.new(key, value)
      @map[key] = node
      insert_front(node)
      if @map.size > @capacity
        lru = @tail.prev_node
        remove(lru)
        @map.delete(lru.key)
      end
    end
  end

  def to_a
    result = []
    node = @head.next_node
    while node != @tail
      result << [node.key, node.value]
      node = node.next_node
    end
    result
  end

  private

  def remove(node)
    node.prev_node.next_node = node.next_node
    node.next_node.prev_node = node.prev_node
  end

  def insert_front(node)
    node.next_node = @head.next_node
    node.prev_node = @head
    @head.next_node.prev_node = node
    @head.next_node = node
  end

  def move_to_front(node)
    remove(node)
    insert_front(node)
  end
end

if __FILE__ == $0
  cache = LRUCache.new(3)
  cache.put(1, 'a')
  cache.put(2, 'b')
  cache.put(3, 'c')
  puts "Cache: #{cache.to_a}"
  cache.get(1) # touches 1, making it most recently used
  cache.put(4, 'd') # evicts 2 (least recently used)
  puts "After accessing 1 and inserting 4: #{cache.to_a}"
  puts "Get 2 (evicted): #{cache.get(2)}"
end
