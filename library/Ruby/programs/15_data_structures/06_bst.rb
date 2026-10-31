# Binary search tree: insert, search, delete and traversals.
class BST
  Node = Struct.new(:key, :left, :right)

  def initialize = @root = nil
  def insert(k) = (@root = ins(@root, k); self)
  def include?(k) = !find(@root, k).nil?
  def delete(k) = (@root = del(@root, k); self)
  def inorder(n = @root) = n ? inorder(n.left) + [n.key] + inorder(n.right) : []
  def preorder(n = @root) = n ? [n.key] + preorder(n.left) + preorder(n.right) : []
  def postorder(n = @root) = n ? postorder(n.left) + postorder(n.right) + [n.key] : []
  def height(n = @root) = n ? 1 + [height(n.left), height(n.right)].max : 0

  def level_order
    return [] unless @root
    levels = []
    queue = [@root]
    until queue.empty?
      levels << queue.map(&:key)
      queue = queue.flat_map { |n| [n.left, n.right].compact }
    end
    levels
  end

  private

  def ins(n, k)
    return Node.new(k) unless n
    k < n.key ? n.left = ins(n.left, k) : n.right = ins(n.right, k)
    n
  end

  def find(n, k)
    n = k < n.key ? n.left : n.right while n && n.key != k
    n
  end

  def del(n, k)
    return nil unless n
    if k < n.key then n.left = del(n.left, k)
    elsif k > n.key then n.right = del(n.right, k)
    else
      return n.right unless n.left
      return n.left unless n.right
      succ = n.right
      succ = succ.left while succ.left
      n.key = succ.key
      n.right = del(n.right, succ.key)
    end
    n
  end
end

t = BST.new
[50, 30, 70, 20, 40, 60, 80, 35, 45, 65].each { |k| t.insert(k) }
puts "inorder:   #{t.inorder.inspect}"
puts "preorder:  #{t.preorder.inspect}"
puts "postorder: #{t.postorder.inspect}"
puts "levels:    #{t.level_order.inspect}"
puts "height #{t.height}, has 45? #{t.include?(45)}, has 55? #{t.include?(55)}"
t.delete(30).delete(70).delete(20)
puts "after deletes: #{t.inorder.inspect}, levels #{t.level_order.inspect}"
