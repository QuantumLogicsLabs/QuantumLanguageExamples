# Sorting by computed keys, ties and stability.
people = [["Ana", 30], ["Ben", 25], ["Cy", 30], ["Dee", 25], ["Eli", 35], ["Fay", 30]]

puts people.sort_by { |_, age| age }.map(&:first).join(" ")
stable = people.each_with_index.sort_by { |(_, age), i| [age, i] }.map { |(name, _), _| name }
puts stable.join(" ")
puts people.sort_by { |name, age| [-age, name] }.map(&:first).join(" ")
puts people.sort { |a, b| b[1] <=> a[1] }.first[0]
puts people.min_by(&:last).inspect
puts people.sort_by(&:first).reverse.map(&:first).join(" ")
words = %w[banana Apple cherry apple Banana]
puts words.sort.inspect
puts words.sort_by { |w| [w.downcase, w] }.inspect
puts words.sort_by(&:length).inspect.length
puts [3, 1, 2].sort.reverse.inspect
puts [3, 1, 2].sort { |a, b| b <=> a }.inspect
