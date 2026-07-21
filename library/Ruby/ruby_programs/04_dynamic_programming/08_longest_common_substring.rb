# Longest Common Substring (contiguous, unlike subsequence) via DP,
# tracking the best run length ending at each pair of positions.
def longest_common_substring(a, b)
  m, n = a.length, b.length
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  max_len = 0
  end_idx = 0

  (1..m).each do |i|
    (1..n).each do |j|
      if a[i - 1] == b[j - 1]
        dp[i][j] = dp[i - 1][j - 1] + 1
        if dp[i][j] > max_len
          max_len = dp[i][j]
          end_idx = i
        end
      end
    end
  end

  [max_len, a[end_idx - max_len, max_len]]
end

if __FILE__ == $0
  a = "GeeksforGeeks"
  b = "GeeksQuiz"
  length, substring = longest_common_substring(a, b)
  puts "Longest common substring length: #{length}, value: '#{substring}'"
end
