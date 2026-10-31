# Counts vowels, consonants and letter frequencies.
text = "The quick brown fox jumps over the lazy dog"

vowels = text.downcase.count("aeiou")
letters = text.count("a-zA-Z")
puts "Text: #{text}"
puts "Letters: #{letters}, vowels: #{vowels}, consonants: #{letters - vowels}"

freq = text.downcase.delete("^a-z").chars.tally
top = freq.sort_by { |ch, n| [-n, ch] }.first(5)
puts "Most common letters:"
top.each { |ch, n| puts "  #{ch}: #{'#' * n} (#{n})" }

pangram = ("a".."z").all? { |c| text.downcase.include?(c) }
puts "Pangram? #{pangram}"
