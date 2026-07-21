# Boyer-Moore substring search (bad character heuristic): compares the
# pattern right-to-left and skips ahead using mismatch information,
# often sub-linear in practice.
def boyer_moore_search(text, pattern)
  n, m = text.length, pattern.length
  return [] if m.zero? || m > n

  last_occurrence = Hash.new(-1)
  pattern.each_char.with_index { |ch, i| last_occurrence[ch] = i }

  matches = []
  s = 0 # shift of pattern relative to text
  while s <= n - m
    j = m - 1
    j -= 1 while j >= 0 && pattern[j] == text[s + j]
    if j < 0
      matches << s
      s += (s + m < n ? m - last_occurrence[text[s + m]] : 1)
    else
      s += [1, j - last_occurrence[text[s + j]]].max
    end
  end
  matches
end

if __FILE__ == $0
  text = "ABAAABCDABABCABAB"
  pattern = "ABABCABAB"
  puts "Matches at indices: #{boyer_moore_search(text, pattern)}"
end
