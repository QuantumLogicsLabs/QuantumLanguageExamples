# Word frequencies in a paragraph.
paragraph = <<~TEXT
  It was the best of times, it was the worst of times, it was the age of
  wisdom, it was the age of foolishness, it was the epoch of belief, it was
  the epoch of incredulity.
TEXT

words = paragraph.downcase.scan(/[a-z']+/)
counts = words.tally
puts "#{words.size} words, #{counts.size} distinct"

counts.sort_by { |w, c| [-c, w] }.first(6).each do |word, count|
  puts "#{word.ljust(12)} #{count}"
end

longest = counts.keys.max_by(&:length)
puts "Longest word: #{longest} (#{longest.length} letters)"
once = counts.select { |_, c| c == 1 }.keys.sort
puts "Used once: #{once.join(' ')}"
