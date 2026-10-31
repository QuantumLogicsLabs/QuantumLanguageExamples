# Combining sequences with zip and indexes.
names = %w[Ana Ben Cy Dee]
scores = [88, 92, 79, 95]
ages = [21, 34, 28]

puts names.zip(scores).inspect
puts names.zip(scores, ages).inspect
names.zip(scores).each { |n, s| puts "#{n}: #{s}" }
puts names.each_with_index.map { |n, i| "#{i + 1}.#{n}" }.join(" ")
puts names.each.with_index(1).to_a.inspect
puts scores.zip(scores.drop(1)).map { |a, b| b && b - a }.compact.inspect
puts names.zip(scores).sort_by { |_, s| -s }.map(&:first).inspect
puts names.zip(scores).to_h.inspect
puts [1, 2, 3].zip([4, 5, 6]).map { |a, b| a * b }.sum
top = names.zip(scores).max_by(&:last)
puts "Top: #{top.join(' with ')}"
