# Readability statistics for a short passage.
PASSAGE = <<~P
  The cat sat on the mat. It was a sunny day, and the cat was very happy.
  Meanwhile, an extraordinarily complicated administrative organization deliberated interminably.
  Short words help. Long sentences with many polysyllabic constructions hinder comprehension considerably.
P

def syllables(word)
  w = word.downcase.delete("^a-z")
  return 0 if w.empty?
  count = w.scan(/[aeiouy]+/).size
  count -= 1 if w.end_with?("e") && count > 1
  [count, 1].max
end

sentences = PASSAGE.split(/(?<=[.!?])\s+/).map(&:strip).reject(&:empty?)
words = PASSAGE.scan(/[A-Za-z']+/)
syl = words.sum { |w| syllables(w) }
flesch = 206.835 - 1.015 * (words.size.to_f / sentences.size) - 84.6 * (syl.to_f / words.size)
puts "sentences #{sentences.size}, words #{words.size}, syllables #{syl}"
puts "Flesch reading ease: #{flesch.round(1)}"
sentences.each do |s|
  w = s.scan(/[A-Za-z']+/)
  puts "#{w.size.to_s.rjust(2)} words, #{w.sum { |x| syllables(x) }.to_s.rjust(2)} syllables: #{s[0, 40]}"
end
puts "hardest words: #{words.uniq.max_by(3) { |w| [syllables(w), w] }.inspect}"
