# A wc-like report for a block of text.
TEXT = <<~T
  Ruby is a dynamic, open source programming language with a focus on
  simplicity and productivity. It has an elegant syntax that is natural
  to read and easy to write.

  Ruby was created by Yukihiro Matsumoto in the mid-1990s.
T

lines = TEXT.lines
words = TEXT.split
puts "lines: #{lines.size}"
puts "non-empty lines: #{lines.count { |l| !l.strip.empty? }}"
puts "words: #{words.size}"
puts "characters: #{TEXT.size}"
puts "letters: #{TEXT.count('a-zA-Z')}"
puts "sentences: #{TEXT.scan(/[.!?](\s|\z)/).size}"
puts "average word length: #{(words.sum { |w| w.delete('^a-zA-Z').size } / words.size.to_f).round(2)}"
puts "longest line: #{lines.max_by(&:size).strip.inspect}"
puts "capitalised words: #{words.grep(/\A[A-Z]/).inspect}"
