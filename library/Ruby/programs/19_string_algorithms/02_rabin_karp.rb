# Rabin-Karp search with a rolling hash.
BASE = 256
MOD = 1_000_003

def rabin_karp(text, pat)
  m = pat.size
  return [] if m > text.size
  high = BASE.pow(m - 1, MOD)
  ph = pat.bytes.reduce(0) { |h, b| (h * BASE + b) % MOD }
  th = text[0, m].bytes.reduce(0) { |h, b| (h * BASE + b) % MOD }
  hits = []
  collisions = 0
  (0..text.size - m).each do |i|
    if th == ph
      text[i, m] == pat ? hits << i : collisions += 1
    end
    break if i + m >= text.size
    th = ((th - text.getbyte(i) * high) * BASE + text.getbyte(i + m)) % MOD
  end
  [hits, collisions]
end

text = "the quick brown fox jumps over the lazy dog; the end"
%w[the fox dog cat e].each do |p|
  hits, coll = rabin_karp(text, p)
  puts "#{p.ljust(3)} #{hits.inspect} (#{coll} false matches)"
end
