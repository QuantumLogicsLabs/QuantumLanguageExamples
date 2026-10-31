# Inverting hashes and grouping keys by value.
grades = { "ann" => "A", "bob" => "B", "cat" => "A", "dan" => "C", "eve" => "B" }

puts grades.invert.inspect
by_grade = grades.group_by { |_, g| g }.transform_values { |pairs| pairs.map(&:first) }
puts by_grade.sort.to_h.inspect

word_lengths = %w[sun moon star sky planet comet].to_h { |w| [w, w.length] }
puts word_lengths.inspect
puts word_lengths.group_by { |_, len| len }.transform_values { |ps| ps.map(&:first) }.inspect
puts word_lengths.max_by { |_, l| l }.inspect
puts word_lengths.sum { |_, l| l }
