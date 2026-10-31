# Kadane's algorithm with the subarray bounds.
def max_subarray(nums)
  best = nums[0]
  best_range = [0, 0]
  current = 0
  start = 0
  nums.each_with_index do |n, i|
    if current <= 0
      current = n
      start = i
    else
      current += n
    end
    if current > best
      best = current
      best_range = [start, i]
    end
  end
  [best, best_range]
end

[[-2, 1, -3, 4, -1, 2, 1, -5, 4], [1, 2, 3], [-3, -1, -2], [5, -9, 6, -2, 3]].each do |nums|
  sum, (i, j) = max_subarray(nums)
  puts "#{nums.inspect}: max #{sum} from #{nums[i..j].inspect}"
end
