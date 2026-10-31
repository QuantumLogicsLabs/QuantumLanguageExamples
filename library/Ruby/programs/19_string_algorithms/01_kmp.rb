# Knuth-Morris-Pratt search with its failure table.
def failure_table(pat)
  table = Array.new(pat.size, 0)
  k = 0
  (1...pat.size).each do |i|
    k = table[k - 1] while k.positive? && pat[i] != pat[k]
    k += 1 if pat[i] == pat[k]
    table[i] = k
  end
  table
end

def kmp_search(text, pat)
  table = failure_table(pat)
  hits = []
  k = 0
  text.each_char.with_index do |ch, i|
    k = table[k - 1] while k.positive? && ch != pat[k]
    k += 1 if ch == pat[k]
    if k == pat.size
      hits << i - k + 1
      k = table[k - 1]
    end
  end
  hits
end

puts failure_table("ABABCABAB").inspect
puts failure_table("AAAA").inspect
puts kmp_search("ABABDABACDABABCABABABABCABAB", "ABABCABAB").inspect
puts kmp_search("aaaaa", "aa").inspect
puts kmp_search("hello world", "xyz").inspect
