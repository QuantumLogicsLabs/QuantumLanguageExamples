# Atbash and rail fence ciphers.
def atbash(s) = s.tr("a-zA-Z", "zyxwvutsrqponmlkjihgfedcbaZYXWVUTSRQPONMLKJIHGFEDCBA")

def rail_pattern(n, rails)
  return Array.new(n, 0) if rails == 1
  cycle = (0...rails).to_a + (1...rails - 1).to_a.reverse
  Array.new(n) { |i| cycle[i % cycle.size] }
end

def rail_encode(s, rails)
  pattern = rail_pattern(s.size, rails)
  (0...rails).flat_map { |r| s.chars.select.with_index { |_, i| pattern[i] == r } }.join
end

def rail_decode(s, rails)
  pattern = rail_pattern(s.size, rails)
  order = (0...s.size).sort_by { |i| [pattern[i], i] }
  out = Array.new(s.size)
  order.each_with_index { |pos, k| out[pos] = s[k] }
  out.join
end

puts atbash("Hello, World!")
puts atbash(atbash("Round trip"))
msg = "WEAREDISCOVEREDFLEEATONCE"
[2, 3, 4].each do |r|
  enc = rail_encode(msg, r)
  puts "#{r} rails: #{enc} -> #{rail_decode(enc, r)}"
end
