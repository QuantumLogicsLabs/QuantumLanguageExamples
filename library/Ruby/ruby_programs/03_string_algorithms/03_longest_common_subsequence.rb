# Longest Common Subsequence via bottom-up DP, with reconstruction
# of the actual subsequence by walking the DP table backward.
def lcs(a, b)
  m, n = a.length, b.length
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }

  (1..m).each do |i|
    (1..n).each do |j|
      dp[i][j] = if a[i - 1] == b[j - 1]
                   dp[i - 1][j - 1] + 1
                 else
                   [dp[i - 1][j], dp[i][j - 1]].max
                 end
    end
  end

  i, j = m, n
  result = []
  while i > 0 && j > 0
    if a[i - 1] == b[j - 1]
      result << a[i - 1]
      i -= 1
      j -= 1
    elsif dp[i - 1][j] >= dp[i][j - 1]
      i -= 1
    else
      j -= 1
    end
  end

  [dp[m][n], result.reverse.join]
end

if __FILE__ == $0
  length, sequence = lcs("ABCBDAB", "BDCABA")
  puts "LCS length: #{length}, sequence: #{sequence}"
end
