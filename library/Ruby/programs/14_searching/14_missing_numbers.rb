# Finding missing and repeated numbers.
def missing_by_sum(a, n) = n * (n + 1) / 2 - a.sum
def missing_by_xor(a, n) = ((1..n).reduce(:^)) ^ a.reduce(0, :^)
def all_missing(a, n) = (1..n).to_a - a

def missing_and_repeated(a)
  n = a.size
  seen = Array.new(n + 1, false)
  repeated = a.find { |x| seen[x] ? true : (seen[x] = true; false) }
  missing = (1..n).find { |x| !seen[x] }
  [missing, repeated]
end

nums = [1, 2, 4, 5, 6, 7, 8]
puts missing_by_sum(nums, 8)
puts missing_by_xor(nums, 8)
puts all_missing([3, 7, 1, 9, 5], 10).inspect
puts missing_and_repeated([3, 1, 3, 4, 5]).inspect
puts missing_and_repeated([1, 1]).inspect
first_missing_positive = ->(a) { (1..).find { |k| !a.include?(k) } }
puts first_missing_positive.([3, 4, -1, 1])
puts first_missing_positive.([7, 8, 9])
