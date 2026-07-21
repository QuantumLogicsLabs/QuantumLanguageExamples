# Knuth-Morris-Pratt substring search: builds a "longest prefix that
# is also a suffix" (LPS) table to avoid re-scanning text on mismatch,
# achieving O(n + m) matching.
def kmp_build_lps(pattern)
  lps = Array.new(pattern.length, 0)
  length = 0
  i = 1
  while i < pattern.length
    if pattern[i] == pattern[length]
      length += 1
      lps[i] = length
      i += 1
    elsif length != 0
      length = lps[length - 1]
    else
      lps[i] = 0
      i += 1
    end
  end
  lps
end

def kmp_search(text, pattern)
  return [] if pattern.empty?
  lps = kmp_build_lps(pattern)
  matches = []
  i = j = 0
  while i < text.length
    if text[i] == pattern[j]
      i += 1
      j += 1
      if j == pattern.length
        matches << (i - j)
        j = lps[j - 1]
      end
    elsif j != 0
      j = lps[j - 1]
    else
      i += 1
    end
  end
  matches
end

if __FILE__ == $0
  text = "ababcabcabababd"
  pattern = "ababd"
  puts "Text: #{text}"
  puts "Pattern: #{pattern}"
  puts "Matches at indices: #{kmp_search(text, pattern)}"

  text2 = "aaaaaaaaaa"
  puts "Matches of 'aaa' in #{text2}: #{kmp_search(text2, 'aaa')}"
end
