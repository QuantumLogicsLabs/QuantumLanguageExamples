# Counting sort for small integer ranges.
def counting_sort(arr)
  return [] if arr.empty?
  min, max = arr.minmax
  counts = Array.new(max - min + 1, 0)
  arr.each { |x| counts[x - min] += 1 }
  counts.each_with_index.flat_map { |c, i| [i + min] * c }
end

def stable_counting_sort(records, &key)
  max = records.map(&key).max
  counts = Array.new(max + 1, 0)
  records.each { |r| counts[key.call(r)] += 1 }
  (1..max).each { |i| counts[i] += counts[i - 1] }
  out = Array.new(records.size)
  records.reverse_each { |r| out[counts[key.call(r)] -= 1] = r }
  out
end

puts counting_sort([4, 2, 2, 8, 3, 3, 1]).inspect
puts counting_sort([-5, 3, 0, -2, 3, -5]).inspect
people = [["ana", 3], ["ben", 1], ["cy", 3], ["dee", 2], ["eli", 1]]
puts stable_counting_sort(people) { |p| p[1] }.map(&:first).inspect
