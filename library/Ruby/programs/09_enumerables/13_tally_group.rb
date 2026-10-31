# Counting and grouping elements.
votes = %w[red blue red green blue red yellow blue red]
puts votes.tally.inspect
puts votes.tally.sort_by { |c, n| [-n, c] }.inspect
puts votes.tally.max_by { |_, n| n }.first
puts votes.group_by(&:itself).transform_values(&:count).inspect
puts votes.uniq.size

grades = [72, 85, 91, 66, 78, 95, 88, 59, 83]
buckets = grades.group_by { |g| g / 10 * 10 }.sort.to_h
buckets.each { |b, gs| puts "#{b}-#{b + 9}: #{gs.sort.inspect}" }
puts grades.partition { |g| g >= 80 }.map(&:size).inspect
puts grades.each_slice(3).map { |s| s.sum / s.size }.inspect
letters = "hello world".delete(" ").chars
puts letters.tally.select { |_, n| n > 1 }.keys.sort.join
