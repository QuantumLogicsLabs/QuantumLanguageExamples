# Matrix chain multiplication order.
def matrix_chain(dims)
  n = dims.size - 1
  cost = Array.new(n) { Array.new(n, 0) }
  split = Array.new(n) { Array.new(n, 0) }
  (2..n).each do |len|
    (0..n - len).each do |i|
      j = i + len - 1
      cost[i][j] = Float::INFINITY
      (i...j).each do |k|
        c = cost[i][k] + cost[k + 1][j] + dims[i] * dims[k + 1] * dims[j + 1]
        if c < cost[i][j]
          cost[i][j] = c
          split[i][j] = k
        end
      end
    end
  end
  [cost[0][n - 1], paren(split, 0, n - 1)]
end

def paren(split, i, j) = i == j ? "M#{i + 1}" : "(#{paren(split, i, split[i][j])} x #{paren(split, split[i][j] + 1, j)})"

[[10, 30, 5, 60], [40, 20, 30, 10, 30], [5, 10, 3, 12, 5, 50, 6]].each do |dims|
  c, order = matrix_chain(dims)
  puts "#{dims.inspect}: #{c} multiplications, #{order}"
end
