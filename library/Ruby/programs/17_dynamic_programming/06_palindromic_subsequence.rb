# Longest palindromic subsequence and minimum insertions to make a palindrome.
def lps(s)
  n = s.size
  dp = Array.new(n) { Array.new(n, 0) }
  (n - 1).downto(0) do |i|
    dp[i][i] = 1
    (i + 1...n).each do |j|
      dp[i][j] = s[i] == s[j] ? dp[i + 1][j - 1] + 2 : [dp[i + 1][j], dp[i][j - 1]].max
    end
  end
  n.zero? ? 0 : dp[0][n - 1]
end

def longest_palindromic_substring(s)
  best = ""
  (0...s.size).each do |center|
    [[center, center], [center, center + 1]].each do |l, r|
      l, r = l - 1, r + 1 while l >= 0 && r < s.size && s[l] == s[r]
      best = s[l + 1...r] if r - l - 1 > best.size
    end
  end
  best
end

%w[bbbab character racecar abcdef forgeeksskeegfor].each do |w|
  puts "#{w}: subsequence #{lps(w)}, insertions #{w.size - lps(w)}, substring #{longest_palindromic_substring(w).inspect}"
end
