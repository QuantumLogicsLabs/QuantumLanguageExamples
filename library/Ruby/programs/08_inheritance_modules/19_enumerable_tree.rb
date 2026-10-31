# A binary search tree that is Enumerable.
class Tree
  include Enumerable
  Node = Struct.new(:value, :left, :right)

  def initialize(values = [])
    @root = nil
    values.each { |v| insert(v) }
  end

  def insert(v)
    @root = insert_at(@root, v)
    self
  end

  def each(&block)
    walk(@root, &block)
    self
  end

  def depth(node = @root) = node ? 1 + [depth(node.left), depth(node.right)].max : 0

  private

  def insert_at(node, v)
    return Node.new(v) unless node
    v < node.value ? node.left = insert_at(node.left, v) : node.right = insert_at(node.right, v)
    node
  end

  def walk(node, &block)
    return unless node
    walk(node.left, &block)
    block.call(node.value)
    walk(node.right, &block)
  end
end

t = Tree.new([50, 30, 70, 20, 40, 60, 80, 35, 65])
puts t.to_a.inspect
puts t.select(&:even?).inspect
puts t.min, t.max
puts t.sum
puts t.include?(65)
puts t.first(3).inspect
puts t.each_slice(4).to_a.inspect
puts t.depth
puts t.map { |v| v / 10 }.uniq.inspect
