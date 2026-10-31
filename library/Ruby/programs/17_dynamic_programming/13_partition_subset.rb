# Splitting numbers into two groups of equal (or closest) sums.
def can_partition(nums)
  total = nums.sum
  return false if total.odd?
  reachable = Set[0]
  nums.each { |n| reachable |= reachable.map { |s| s + n } }
  reachable.include?(total / 2)
end

def closest_split(nums)
  total = nums.sum
  sums = { 0 => [] }
  nums.each do |n|
    sums.dup.each { |s, picked| sums[s + n] ||= picked + [n] }
  end
  best = sums.keys.select { |s| s <= total / 2 }.max
  a = sums[best]
  b = nums.dup
  a.each { |x| b.delete_at(b.index(x)) }
  [a, b]
end

[[1, 5, 11, 5], [1, 2, 3, 5], [3, 1, 4, 2, 2], [10, 20, 15, 5, 25], [7, 3, 2, 9]].each do |nums|
  a, b = closest_split(nums)
  puts "#{nums.inspect}: equal split #{can_partition(nums)}; best #{a.inspect}=#{a.sum} vs #{b.inspect}=#{b.sum}"
end
