# Edit distance (Levenshtein distance): minimum number of single-
# character insertions, deletions, or substitutions to turn one
# string into another, via bottom-up DP.
def edit_distance(a, b)
  m, n = a.length, b.length
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }

  (0..m).each { |i| dp[i][0] = i }
  (0..n).each { |j| dp[0][j] = j }

  (1..m).each do |i|
    (1..n).each do |j|
      dp[i][j] = if a[i - 1] == b[j - 1]
                   dp[i - 1][j - 1]
                 else
                   1 + [dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]].min
                 end
    end
  end
  dp[m][n]
end

if __FILE__ == $0
  pairs = [["kitten", "sitting"], ["flaw", "lawn"], ["intention", "execution"]]
  pairs.each { |a, b| puts "edit_distance(#{a}, #{b}) = #{edit_distance(a, b)}" }
end
