# Run-length encoding and decoding.
def encode(text)
  text.chars.chunk_while { |a, b| a == b }.map { |run| "#{run.size}#{run.first}" }.join
end

def decode(code)
  code.scan(/(\d+)(\D)/).map { |n, ch| ch * n.to_i }.join
end

samples = ["WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWBWWWWWWWWWWWWWW", "aabcccccaaa", "abc", "zzzzzzzzzz"]
samples.each do |s|
  enc = encode(s)
  ok = decode(enc) == s
  ratio = (enc.length.to_f / s.length * 100).round
  puts "#{s[0, 20].ljust(20)} -> #{enc} (#{ratio}%, round trip #{ok})"
end
