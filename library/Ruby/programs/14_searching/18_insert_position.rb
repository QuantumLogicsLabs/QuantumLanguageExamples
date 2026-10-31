# Where would a value go in a sorted list?
def insert_position(a, x) = a.bsearch_index { |v| v >= x } || a.size

list = [1, 3, 5, 6]
[5, 2, 7, 0, 3].each { |x| puts "#{x} -> #{insert_position(list, x)}" }

sorted = []
[42, 7, 19, 7, 100, 3, 64].each do |x|
  sorted.insert(insert_position(sorted, x), x)
  puts sorted.inspect
end

scores = [55, 62, 70, 81, 90]
grade = ->(s) { %w[F D C B A][[insert_position(scores, s + 1) - 1, 0].max] }
[50, 62, 75, 81, 99].each { |s| puts "#{s}: #{grade.(s)}" }
