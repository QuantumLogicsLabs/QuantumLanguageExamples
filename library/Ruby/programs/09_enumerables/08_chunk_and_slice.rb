# Grouping consecutive elements.
log = %w[INFO INFO WARN ERROR ERROR ERROR INFO WARN WARN]
puts log.chunk { |l| l }.map { |level, items| "#{level}x#{items.size}" }.join(" ")

lines = ["# Title", "intro", "more", "# Part 2", "body", "# Part 3"]
sections = lines.slice_before { |l| l.start_with?("#") }.to_a
sections.each { |s| puts "#{s.first}: #{s.size - 1} lines" }

stmts = %w[a b ; c ; d e f ;]
puts stmts.slice_after(";").map { |s| s.join(" ") }.inspect

nums = [1, 2, 4, 9, 10, 11, 12, 15, 16, 19]
puts nums.slice_when { |a, b| b != a + 1 }.map { |r| r.size == 1 ? r[0].to_s : "#{r[0]}-#{r[-1]}" }.join(",")
puts nums.chunk(&:even?).map { |even, xs| [even ? "E" : "O", xs] }.inspect
words = %w[apple avocado banana blueberry cherry apricot]
puts words.chunk { |w| w[0] }.to_a.inspect
