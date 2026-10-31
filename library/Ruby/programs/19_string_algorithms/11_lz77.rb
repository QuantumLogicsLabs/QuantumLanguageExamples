# A small LZ77 compressor and decompressor.
def lz77_compress(data, window = 12)
  out = []
  i = 0
  while i < data.size
    best_len = best_off = 0
    ([0, i - window].max...i).each do |j|
      len = 0
      len += 1 while i + len < data.size - 1 && data[j + len] == data[i + len] && len < 15
      if len > best_len
        best_len = len
        best_off = i - j
      end
    end
    out << [best_off, best_len, data[i + best_len]]
    i += best_len + 1
  end
  out
end

def lz77_decompress(tokens)
  out = +""
  tokens.each do |off, len, ch|
    start = out.size - off
    len.times { |k| out << out[start + k] }
    out << ch if ch
  end
  out
end

%w[abracadabra aaaaaaaaaaaa abcabcabcabcx mississippi].each do |s|
  tokens = lz77_compress(s)
  back = lz77_decompress(tokens)
  puts "#{s}: #{tokens.size} tokens #{tokens.map { |o, l, c| "(#{o},#{l},#{c})" }.join} ok=#{back == s}"
end
