# Subset Sum: does any subset of the array sum to a target? Includes
# a space-efficient existence check and a full reconstruction of one
# valid subset.
def subset_sum_exists?(arr, target)
  dp = Array.new(target + 1, false)
  dp[0] = true
  arr.each do |num|
    target.downto(num) do |t|
      dp[t] ||= dp[t - num]
    end
  end
  dp[target]
end

def subset_sum_find(arr, target)
  n = arr.length
  dp = Array.new(n + 1) { Array.new(target + 1, false) }
  (0..n).each { |i| dp[i][0] = true }

  (1..n).each do |i|
    (0..target).each do |t|
      dp[i][t] = dp[i - 1][t]
      dp[i][t] ||= dp[i - 1][t - arr[i - 1]] if arr[i - 1] <= t
    end
  end
  return nil unless dp[n][target]

  subset = []
  t = target
  n.downto(1) do |i|
    if dp[i][t] && !dp[i - 1][t]
      subset << arr[i - 1]
      t -= arr[i - 1]
    end
  end
  subset
end

if __FILE__ == $0
  arr = [3, 34, 4, 12, 5, 2]
  puts "Subset summing to 9 exists? #{subset_sum_exists?(arr, 9)}"
  puts "Subset found: #{subset_sum_find(arr, 9)}"
  puts "Subset summing to 100 exists? #{subset_sum_exists?(arr, 100)}"
end
