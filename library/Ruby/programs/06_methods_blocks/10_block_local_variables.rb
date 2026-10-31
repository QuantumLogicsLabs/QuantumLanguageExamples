# Block parameters, block-local variables and shadowing.
x = 10
[1, 2, 3].each { |x| }
puts x

y = 5
[1, 2].each { |n; y| y = n * 100 }
puts y

sum = 0
[1, 2, 3].each { |n| sum += n }
puts sum

pairs = { a: 1, b: 2 }
pairs.each { |key, value| puts "#{key}=#{value}" }
pairs.each { |pair| puts pair.inspect }

[[1, [2, 3]], [4, [5, 6]]].each { |a, (b, c)| puts a + b + c }
%w[x y z].each.with_index(1) { |letter, i| puts "#{i}:#{letter}" }
puts [1, 2, 3].map { it * 10 }.inspect
puts [4, 5].map { _1 + 1 }.inspect
