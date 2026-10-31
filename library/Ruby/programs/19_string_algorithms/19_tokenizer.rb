# A hand-written tokenizer for a small expression language.
Token = Struct.new(:type, :text, :pos) do
  def to_s = "#{type}(#{text})"
end

KEYWORDS = %w[let if then else end].freeze

def tokenize(src)
  tokens = []
  i = 0
  while i < src.size
    c = src[i]
    if c =~ /\s/
      i += 1
    elsif c =~ /\d/
      j = i
      j += 1 while j < src.size && src[j] =~ /[\d.]/
      tokens << Token.new(:number, src[i...j], i)
      i = j
    elsif c =~ /[A-Za-z_]/
      j = i
      j += 1 while j < src.size && src[j] =~ /\w/
      word = src[i...j]
      tokens << Token.new(KEYWORDS.include?(word) ? :keyword : :ident, word, i)
      i = j
    elsif c == '"'
      j = src.index('"', i + 1) or raise "unterminated string at #{i}"
      tokens << Token.new(:string, src[i + 1...j], i)
      i = j + 1
    elsif %w[== <= >= !=].include?(src[i, 2])
      tokens << Token.new(:op, src[i, 2], i)
      i += 2
    elsif "+-*/=<>(),".include?(c)
      tokens << Token.new(:op, c, i)
      i += 1
    else
      raise "unexpected #{c.inspect} at #{i}"
    end
  end
  tokens
end

src = 'let total = price * 1.08 if total >= 100 then "big" else name end'
puts tokenize(src).join(" ")
puts tokenize(src).map(&:type).tally.inspect
['x = "open', "a $ b"].each do |bad|
  tokenize(bad)
rescue RuntimeError => e
  puts "error: #{e.message}"
end
