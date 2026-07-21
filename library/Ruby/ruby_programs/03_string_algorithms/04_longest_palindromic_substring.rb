# Longest palindromic substring via "expand around center", checking
# both odd-length and even-length centers in O(n^2) time, O(1) space.
def longest_palindromic_substring(s)
  return "" if s.empty?
  start, max_len = 0, 1

  expand = lambda do |left, right|
    while left >= 0 && right < s.length && s[left] == s[right]
      left -= 1
      right += 1
    end
    right - left - 1
  end

  (0...s.length).each do |i|
    len1 = expand.call(i, i)
    len2 = expand.call(i, i + 1)
    len = [len1, len2].max
    if len > max_len
      max_len = len
      start = i - (len - 1) / 2
    end
  end

  s[start, max_len]
end

if __FILE__ == $0
  ["babad", "cbbd", "racecarxyz", "a"].each do |s|
    puts "#{s.ljust(15)} => #{longest_palindromic_substring(s)}"
  end
end
