# A trie for prefix search and autocomplete.
class Trie
  Node = Struct.new(:children, :terminal, :count)

  def initialize = @root = new_node

  def insert(word)
    node = @root
    word.each_char do |c|
      node = node.children[c] ||= new_node
      node.count += 1
    end
    node.terminal = true
    self
  end

  def include?(word) = (n = walk(word)) && n.terminal ? true : false
  def prefix_count(prefix) = walk(prefix)&.count || 0

  def complete(prefix)
    node = walk(prefix)
    return [] unless node
    out = []
    collect(node, prefix, out)
    out
  end

  private

  def new_node = Node.new({}, false, 0)

  def walk(s)
    node = @root
    s.each_char do |c|
      node = node.children[c]
      return nil unless node
    end
    node
  end

  def collect(node, prefix, out)
    out << prefix if node.terminal
    node.children.keys.sort.each { |c| collect(node.children[c], prefix + c, out) }
  end
end

trie = Trie.new
%w[car card care careful cart cat dog dodge door do].each { |w| trie.insert(w) }
puts trie.include?("care"), trie.include?("ca")
puts trie.prefix_count("car")
puts trie.complete("car").inspect
puts trie.complete("do").inspect
puts trie.complete("x").inspect
