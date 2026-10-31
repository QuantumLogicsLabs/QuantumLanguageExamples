# Two-sum and three-sum with hashes and sorting.
def two_sum(nums, target)
  seen = {}
  nums.each_with_index do |n, i|
    j = seen[target - n]
    return [j, i] if j
    seen[n] = i
  end
  nil
end

def three_sum_zero(nums)
  s = nums.sort
  result = []
  s.each_with_index do |a, i|
    next if i.positive? && a == s[i - 1]
    lo, hi = i + 1, s.size - 1
    while lo < hi
      sum = a + s[lo] + s[hi]
      if sum.zero?
        result << [a, s[lo], s[hi]]
        lo += 1
        lo += 1 while lo < hi && s[lo] == s[lo - 1]
      elsif sum.negative? then lo += 1
      else hi -= 1
      end
    end
  end
  result
end

puts two_sum([2, 7, 11, 15], 9).inspect
puts two_sum([3, 2, 4], 6).inspect
puts two_sum([1, 2, 3], 10).inspect
puts three_sum_zero([-1, 0, 1, 2, -1, -4]).inspect
puts three_sum_zero([0, 0, 0, 0]).inspect
