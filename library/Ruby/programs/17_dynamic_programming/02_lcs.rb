# Longest common subsequence with the subsequence itself.
def lcs(a, b)
  dp = Array.new(a.size + 1) { Array.new(b.size + 1, 0) }
  a.each_char.with_index(1) do |ca, i|
    b.each_char.with_index(1) do |cb, j|
      dp[i][j] = ca == cb ? dp[i - 1][j - 1] + 1 : [dp[i - 1][j], dp[i][j - 1]].max
    end
  end
  i, j = a.size, b.size
  out = +""
  while i.positive? && j.positive?
    if a[i - 1] == b[j - 1]
      out.prepend(a[i - 1])
      i -= 1
      j -= 1
    elsif dp[i - 1][j] >= dp[i][j - 1]
      i -= 1
    else
      j -= 1
    end
  end
  out
end

[%w[ABCBDAB BDCABA], %w[AGGTAB GXTXAYB], %w[kitten sitting], %w[abc xyz], %w[dynamic programming]].each do |a, b|
  s = lcs(a, b)
  puts "#{a} / #{b}: #{s.inspect} (#{s.length})"
end
