# Natural merge sort: merge the runs already present in the data.
def runs(a) = a.slice_when { |x, y| y < x }.to_a

def merge_two(x, y)
  out = []
  out << (x.first <= y.first ? x.shift : y.shift) until x.empty? || y.empty?
  out + x + y
end

def natural_merge_sort(a)
  rs = runs(a)
  round = 0
  while rs.size > 1
    round += 1
    puts "round #{round}: #{rs.size} runs #{rs.inspect}"
    rs = rs.each_slice(2).map { |p, q| q ? merge_two(p.dup, q.dup) : p }
  end
  rs.first || []
end

puts natural_merge_sort([3, 4, 9, 1, 2, 8, 5, 6, 7, 0]).inspect
puts natural_merge_sort([1, 2, 3, 4]).inspect
