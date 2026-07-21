# Longest Increasing Subsequence: an O(n log n) length-only solution
# using patience sorting (binary search over "tails"), plus an O(n^2)
# solution that reconstructs the actual sequence.
def lis_length(arr)
  return 0 if arr.empty?
  tails = []
  arr.each do |x|
    pos = tails.bsearch_index { |t| t >= x }
    if pos
      tails[pos] = x
    else
      tails << x
    end
  end
  tails.length
end

def lis_sequence(arr)
  n = arr.length
  dp = Array.new(n, 1)
  parent = Array.new(n, -1)

  (0...n).each do |i|
    (0...i).each do |j|
      if arr[j] < arr[i] && dp[j] + 1 > dp[i]
        dp[i] = dp[j] + 1
        parent[i] = j
      end
    end
  end

  max_idx = dp.each_index.max_by { |i| dp[i] }
  sequence = []
  while max_idx != -1
    sequence << arr[max_idx]
    max_idx = parent[max_idx]
  end
  sequence.reverse
end

if __FILE__ == $0
  arr = [10, 9, 2, 5, 3, 7, 101, 18]
  puts "LIS length (O(n log n)): #{lis_length(arr)}"
  puts "LIS sequence (O(n^2)): #{lis_sequence(arr)}"
end
