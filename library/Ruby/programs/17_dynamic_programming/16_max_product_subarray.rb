# Maximum product subarray, tracking min and max.
def max_product(nums)
  best = hi = lo = nums[0]
  range = [0, 0]
  hi_start = lo_start = 0
  nums.each_with_index do |x, i|
    next if i.zero?
    candidates = [[x, i], [hi * x, hi_start], [lo * x, lo_start]]
    hi, hi_start = candidates.max_by(&:first)
    lo, lo_start = candidates.min_by(&:first)
    if hi > best
      best = hi
      range = [hi_start, i]
    end
  end
  [best, nums[range[0]..range[1]]]
end

[[2, 3, -2, 4], [-2, 0, -1], [-2, 3, -4], [6, -3, -10, 0, 2], [-1, -3, -10, 0, 60], [5]].each do |nums|
  best, sub = max_product(nums)
  puts "#{nums.inspect}: #{best} from #{sub.inspect}"
end
