# Huffman codes: build the tree, encode and decode.
Node = Struct.new(:weight, :char, :left, :right, :order)

def huffman_codes(text)
  freq = text.chars.tally
  counter = 0
  queue = freq.sort.map { |c, w| Node.new(w, c, nil, nil, counter += 1) }
  while queue.size > 1
    queue.sort_by! { |n| [n.weight, n.order] }
    a, b = queue.shift(2)
    queue << Node.new(a.weight + b.weight, nil, a, b, counter += 1)
  end
  codes = {}
  walk = ->(node, prefix) do
    if node.char
      codes[node.char] = prefix.empty? ? "0" : prefix
    else
      walk.(node.left, prefix + "0")
      walk.(node.right, prefix + "1")
    end
  end
  walk.(queue.first, "")
  codes
end

text = "this is an example of a huffman tree"
codes = huffman_codes(text)
codes.sort_by { |c, code| [code.size, c] }.each { |c, code| puts "#{c.inspect} #{code}" }
encoded = text.chars.map { |c| codes[c] }.join
decode = codes.invert
decoded = +""
buf = +""
encoded.each_char { |b| buf << b; (decoded << decode[buf]; buf = +"") if decode.key?(buf) }
puts "#{text.size * 8} bits -> #{encoded.size} bits, round trip #{decoded == text}"
