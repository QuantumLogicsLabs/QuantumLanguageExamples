# Edit distance with the list of operations.
def edit_script(a, b)
  dp = Array.new(a.size + 1) { |i| Array.new(b.size + 1) { |j| i.zero? ? j : (j.zero? ? i : 0) } }
  (1..a.size).each do |i|
    (1..b.size).each do |j|
      cost = a[i - 1] == b[j - 1] ? 0 : 1
      dp[i][j] = [dp[i - 1][j] + 1, dp[i][j - 1] + 1, dp[i - 1][j - 1] + cost].min
    end
  end
  ops = []
  i, j = a.size, b.size
  while i.positive? || j.positive?
    if i.positive? && j.positive? && a[i - 1] == b[j - 1] && dp[i][j] == dp[i - 1][j - 1]
      i -= 1; j -= 1
    elsif i.positive? && j.positive? && dp[i][j] == dp[i - 1][j - 1] + 1
      ops.unshift("replace #{a[i - 1]}->#{b[j - 1]}")
      i -= 1; j -= 1
    elsif i.positive? && dp[i][j] == dp[i - 1][j] + 1
      ops.unshift("delete #{a[i - 1]}")
      i -= 1
    else
      ops.unshift("insert #{b[j - 1]}")
      j -= 1
    end
  end
  [dp[a.size][b.size], ops]
end

[%w[kitten sitting], %w[sunday saturday], %w[abc abc], %w[horse ros]].each do |a, b|
  d, ops = edit_script(a, b)
  puts "#{a} -> #{b}: #{d} (#{ops.join(', ')})"
end
