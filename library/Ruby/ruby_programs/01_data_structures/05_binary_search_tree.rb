# Unbalanced Binary Search Tree with insert, search, delete (including
# the two-children successor case), inorder traversal, and height.
class BSTNode
  attr_accessor :value, :left, :right
  def initialize(value)
    @value = value
  end
end

class BST
  def initialize
    @root = nil
  end

  def insert(value)
    @root = insert_node(@root, value)
    self
  end

  def search(value)
    node = @root
    while node
      return true if node.value == value
      node = value < node.value ? node.left : node.right
    end
    false
  end

  def delete(value)
    @root = delete_node(@root, value)
  end

  def inorder
    result = []
    traverse(@root) { |v| result << v }
    result
  end

  def height(node = @root)
    return -1 if node.nil?
    1 + [height(node.left), height(node.right)].max
  end

  private

  def insert_node(node, value)
    return BSTNode.new(value) if node.nil?
    if value < node.value
      node.left = insert_node(node.left, value)
    elsif value > node.value
      node.right = insert_node(node.right, value)
    end
    node
  end

  def delete_node(node, value)
    return nil if node.nil?
    if value < node.value
      node.left = delete_node(node.left, value)
    elsif value > node.value
      node.right = delete_node(node.right, value)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?
      successor = node.right
      successor = successor.left while successor.left
      node.value = successor.value
      node.right = delete_node(node.right, successor.value)
    end
    node
  end

  def traverse(node, &block)
    return unless node
    traverse(node.left, &block)
    block.call(node.value)
    traverse(node.right, &block)
  end
end

if __FILE__ == $0
  bst = BST.new
  [50, 30, 70, 20, 40, 60, 80].each { |v| bst.insert(v) }
  puts "Inorder: #{bst.inorder}"
  puts "Height: #{bst.height}"
  puts "Search 40: #{bst.search(40)}, Search 99: #{bst.search(99)}"
  bst.delete(30)
  puts "After deleting 30: #{bst.inorder}"
end
