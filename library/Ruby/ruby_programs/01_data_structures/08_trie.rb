# Trie (prefix tree) supporting insert, exact search, prefix search,
# and autocomplete -- the classic building block behind text predictors.
class TrieNode
  attr_accessor :children, :is_word
  def initialize
    @children = {}
    @is_word = false
  end
end

class Trie
  def initialize
    @root = TrieNode.new
  end

  def insert(word)
    node = @root
    word.each_char do |ch|
      node = (node.children[ch] ||= TrieNode.new)
    end
    node.is_word = true
    self
  end

  def search(word)
    node = find_node(word)
    !node.nil? && node.is_word
  end

  def starts_with?(prefix)
    !find_node(prefix).nil?
  end

  def autocomplete(prefix)
    node = find_node(prefix)
    return [] unless node
    results = []
    collect_words(node, prefix, results)
    results
  end

  private

  def find_node(str)
    node = @root
    str.each_char do |ch|
      node = node.children[ch]
      return nil unless node
    end
    node
  end

  def collect_words(node, prefix, results)
    results << prefix if node.is_word
    node.children.each { |ch, child| collect_words(child, prefix + ch, results) }
  end
end

if __FILE__ == $0
  trie = Trie.new
  %w[cat car card care dog do dorm].each { |w| trie.insert(w) }
  puts "Search 'car': #{trie.search('car')}"
  puts "Search 'ca': #{trie.search('ca')}"
  puts "Starts with 'ca': #{trie.starts_with?('ca')}"
  puts "Autocomplete 'car': #{trie.autocomplete('car')}"
  puts "Autocomplete 'do': #{trie.autocomplete('do')}"
end
