# A self-balancing AVL tree.
class AVL
  Node = Struct.new(:key, :left, :right, :height)

  def initialize = @root = nil
  def insert(k) = (@root = ins(@root, k); self)
  def keys(n = @root) = n ? keys(n.left) + [n.key] + keys(n.right) : []
  def height = h(@root)
  def root_key = @root&.key

  def shape(n = @root)
    return "." unless n
    return n.key.to_s unless n.left || n.right
    "(#{shape(n.left)} #{n.key} #{shape(n.right)})"
  end

  private

  def h(n) = n ? n.height : 0
  def fix(n) = (n.height = 1 + [h(n.left), h(n.right)].max; n)
  def balance(n) = h(n.left) - h(n.right)

  def rotate_right(y)
    x = y.left
    y.left = x.right
    x.right = fix(y)
    fix(x)
  end

  def rotate_left(x)
    y = x.right
    x.right = y.left
    y.left = fix(x)
    fix(y)
  end

  def ins(n, k)
    return Node.new(k, nil, nil, 1) unless n
    k < n.key ? n.left = ins(n.left, k) : n.right = ins(n.right, k)
    fix(n)
    b = balance(n)
    if b > 1
      n.left = rotate_left(n.left) if k > n.left.key
      return rotate_right(n)
    elsif b < -1
      n.right = rotate_right(n.right) if k < n.right.key
      return rotate_left(n)
    end
    n
  end
end

tree = AVL.new
(1..15).each { |k| tree.insert(k) }
puts tree.keys.inspect
puts "height #{tree.height} (a plain BST would be 15), root #{tree.root_key}"
puts tree.shape
t2 = AVL.new
[50, 20, 60, 10, 30, 25, 27].each { |k| t2.insert(k) }
puts t2.shape
