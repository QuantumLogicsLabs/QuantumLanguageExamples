# Self-balancing AVL Tree. Maintains O(log n) height via rotations
# after every insert, unlike a plain BST which can degrade to O(n).
class AVLNode
  attr_accessor :value, :left, :right, :height
  def initialize(value)
    @value = value
    @height = 1
  end
end

class AVLTree
  def insert(value)
    @root = insert_node(@root, value)
    self
  end

  def inorder
    result = []
    traverse(@root) { |v| result << v }
    result
  end

  def balance_factor(node)
    node ? height(node.left) - height(node.right) : 0
  end

  private

  def height(node)
    node ? node.height : 0
  end

  def update_height(node)
    node.height = 1 + [height(node.left), height(node.right)].max
  end

  def rotate_right(y)
    x = y.left
    t2 = x.right
    x.right = y
    y.left = t2
    update_height(y)
    update_height(x)
    x
  end

  def rotate_left(x)
    y = x.right
    t2 = y.left
    y.left = x
    x.right = t2
    update_height(x)
    update_height(y)
    y
  end

  def insert_node(node, value)
    return AVLNode.new(value) if node.nil?
    if value < node.value
      node.left = insert_node(node.left, value)
    elsif value > node.value
      node.right = insert_node(node.right, value)
    else
      return node
    end

    update_height(node)
    bf = balance_factor(node)

    return rotate_right(node) if bf > 1 && value < node.left.value
    return rotate_left(node) if bf < -1 && value > node.right.value
    if bf > 1 && value > node.left.value
      node.left = rotate_left(node.left)
      return rotate_right(node)
    end
    if bf < -1 && value < node.right.value
      node.right = rotate_right(node.right)
      return rotate_left(node)
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
  avl = AVLTree.new
  [10, 20, 30, 40, 50, 25].each { |v| avl.insert(v) }
  puts "Inorder (sorted): #{avl.inorder}"
  puts "Tree stays balanced (rotations trigger) even though inserts are sequential/skewed."
end
