# Rabin-Karp substring search using a rolling polynomial hash so each
# window's hash is computed in O(1) from the previous one.
def rabin_karp(text, pattern, base = 256, mod = 1_000_000_007)
  n, m = text.length, pattern.length
  return [] if m > n || m.zero?

  high_order = base.pow(m - 1, mod)
  pattern_hash = 0
  text_hash = 0

  m.times do |i|
    pattern_hash = (pattern_hash * base + pattern[i].ord) % mod
    text_hash = (text_hash * base + text[i].ord) % mod
  end

  matches = []
  (0..n - m).each do |i|
    matches << i if pattern_hash == text_hash && text[i, m] == pattern
    if i < n - m
      text_hash = ((text_hash - text[i].ord * high_order) * base + text[i + m].ord) % mod
      text_hash += mod if text_hash.negative?
    end
  end
  matches
end

if __FILE__ == $0
  text = "GEEKS FOR GEEKS"
  pattern = "GEEK"
  puts "Matches at indices: #{rabin_karp(text, pattern)}"
end
