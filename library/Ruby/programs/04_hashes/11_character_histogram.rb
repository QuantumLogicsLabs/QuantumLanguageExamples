# A vertical and horizontal histogram of letters.
text = "hello histogram world of hashes"
counts = text.delete(" ").chars.tally.sort.to_h

counts.each { |ch, n| puts "#{ch} #{'*' * n}" }

max = counts.values.max
max.downto(1) do |level|
  puts counts.values.map { |n| n >= level ? "#" : " " }.join
end
puts counts.keys.join
puts "Most frequent: #{counts.select { |_, n| n == max }.keys.join(', ')}"
