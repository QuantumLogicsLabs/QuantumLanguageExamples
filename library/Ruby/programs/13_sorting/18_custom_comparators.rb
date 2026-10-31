# Sorting with custom ordering rules.
files = %w[file10.txt file2.txt File1.txt file1.txt notes.md file20.txt readme]

natural = files.sort_by { |f| f.downcase.split(/(\d+)/).map { |part| part.match?(/\A\d+\z/) ? [0, part.to_i] : [1, part] } }
puts natural.inspect

priority = { "critical" => 0, "high" => 1, "normal" => 2, "low" => 3 }
tickets = [["low", 5], ["critical", 9], ["normal", 2], ["critical", 3], ["high", 7]]
puts tickets.sort_by { |p, age| [priority[p], -age] }.inspect

puts %w[banana kiwi apple fig].sort { |a, b| [a.length, a] <=> [b.length, b] }.inspect
puts [3, -7, 1, -2, 5].sort_by(&:abs).inspect
puts [3, -7, 1, -2, 5].sort { |a, b| (a.even? ? 0 : 1) <=> (b.even? ? 0 : 1) }.first
evens_first = [5, 2, 8, 1, 4, 7].partition(&:even?).map(&:sort).flatten
puts evens_first.inspect
