# Word Search II: find all dictionary words hidden in a 2D letter
# board (up/down/left/right chains) using a Trie to prune the DFS
# search space -- far faster than searching each word independently.
class WordSearchTrieNode
  attr_accessor :children, :word
  def initialize
    @children = {}
    @word = nil
  end
end

def build_trie(words)
  root = WordSearchTrieNode.new
  words.each do |word|
    node = root
    word.each_char { |ch| node = (node.children[ch] ||= WordSearchTrieNode.new) }
    node.word = word
  end
  root
end

def find_words(board, words)
  root = build_trie(words)
  rows, cols = board.size, board[0].size
  found = []

  dfs = lambda do |r, c, node|
    return if r < 0 || c < 0 || r >= rows || c >= cols
    ch = board[r][c]
    return if ch == '#' || !node.children[ch]

    next_node = node.children[ch]
    if next_node.word
      found << next_node.word
      next_node.word = nil # avoid duplicate reporting
    end

    board[r][c] = '#' # mark visited
    [[1, 0], [-1, 0], [0, 1], [0, -1]].each { |dr, dc| dfs.call(r + dr, c + dc, next_node) }
    board[r][c] = ch
  end

  (0...rows).each { |r| (0...cols).each { |c| dfs.call(r, c, root) } }
  found
end

if __FILE__ == $0
  board = [
    ['o', 'a', 'a', 'n'],
    ['e', 't', 'a', 'e'],
    ['i', 'h', 'k', 'r'],
    ['i', 'f', 'l', 'v'],
  ]
  words = %w[oath pea eat rain]
  puts "Found words: #{find_words(board, words)}"
end
