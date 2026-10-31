# Suffix array and LCP array (simple construction).
def suffix_array(s) = (0...s.size).sort_by { |i| s[i..] }

def lcp_array(s, sa)
  rank = Array.new(s.size)
  sa.each_with_index { |pos, i| rank[pos] = i }
  lcp = Array.new(s.size, 0)
  h = 0
  s.size.times do |i|
    if rank[i].positive?
      j = sa[rank[i] - 1]
      h += 1 while i + h < s.size && j + h < s.size && s[i + h] == s[j + h]
      lcp[rank[i]] = h
      h -= 1 if h.positive?
    else
      h = 0
    end
  end
  lcp
end

s = "banana"
sa = suffix_array(s)
lcp = lcp_array(s, sa)
sa.each_with_index { |pos, i| puts "#{pos} #{lcp[i]} #{s[pos..]}" }
distinct = s.size * (s.size + 1) / 2 - lcp.sum
puts "distinct substrings of #{s}: #{distinct} (check #{(0...s.size).flat_map { |i| (i...s.size).map { |j| s[i..j] } }.uniq.size})"
