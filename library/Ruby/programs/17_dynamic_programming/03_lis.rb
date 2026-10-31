# Longest increasing subsequence in O(n log n), with reconstruction.
def lis(nums)
  tails = []
  tail_idx = []
  parent = Array.new(nums.size)
  nums.each_with_index do |x, i|
    pos = tails.bsearch_index { |t| t >= x } || tails.size
    tails[pos] = x
    tail_idx[pos] = i
    parent[i] = pos.positive? ? tail_idx[pos - 1] : nil
  end
  seq = []
  k = tail_idx.last
  while k
    seq.unshift(nums[k])
    k = parent[k]
  end
  seq
end

def lis_quadratic(nums)
  dp = Array.new(nums.size, 1)
  nums.each_index { |i| (0...i).each { |j| dp[i] = [dp[i], dp[j] + 1].max if nums[j] < nums[i] } }
  dp.max || 0
end

[[10, 9, 2, 5, 3, 7, 101, 18], [0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15], [5, 4, 3], [1, 2, 3, 4]].each do |a|
  s = lis(a)
  puts "#{s.inspect} length #{s.size} (check #{lis_quadratic(a)})"
end
