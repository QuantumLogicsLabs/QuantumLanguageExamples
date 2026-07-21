# Matrix Chain Multiplication: find the parenthesization that
# minimizes scalar multiplications when multiplying a chain of
# matrices, via interval DP.
def matrix_chain_order(dims)
  n = dims.length - 1 # number of matrices
  dp = Array.new(n) { Array.new(n, 0) }
  split = Array.new(n) { Array.new(n, 0) }

  (1...n).each do |len|
    (0...n - len).each do |i|
      j = i + len
      dp[i][j] = Float::INFINITY
      (i...j).each do |k|
        cost = dp[i][k] + dp[k + 1][j] + dims[i] * dims[k + 1] * dims[j + 1]
        if cost < dp[i][j]
          dp[i][j] = cost
          split[i][j] = k
        end
      end
    end
  end

  parenthesization = lambda do |i, j|
    return "M#{i}" if i == j
    k = split[i][j]
    "(#{parenthesization.call(i, k)} x #{parenthesization.call(k + 1, j)})"
  end

  [dp[0][n - 1], parenthesization.call(0, n - 1)]
end

if __FILE__ == $0
  dims = [40, 20, 30, 10, 30] # 4 matrices
  cost, order = matrix_chain_order(dims)
  puts "Minimum multiplication cost: #{cost}"
  puts "Optimal parenthesization: #{order}"
end
