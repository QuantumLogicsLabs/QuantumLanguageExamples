# A histogram of word lengths in a text.
text = <<~T
  It is a truth universally acknowledged, that a single man in possession
  of a good fortune, must be in want of a wife. However little known the
  feelings or views of such a man may be on his first entering a neighbourhood,
  this truth is so well fixed in the minds of the surrounding families.
T

lengths = text.scan(/[a-z]+/i).map(&:length).tally.sort.to_h
max = lengths.values.max
lengths.each { |len, n| puts "#{len.to_s.rjust(2)} | #{'=' * (n * 30 / max)} #{n}" }
total = lengths.values.sum
mean = lengths.sum { |len, n| len * n }.fdiv(total)
puts "words: #{total}, mean length #{mean.round(2)}"
mode = lengths.max_by { |_, n| n }.first
puts "most common length: #{mode}"
longest = text.scan(/[a-z]+/i).group_by(&:length).max.last.uniq
puts "longest words: #{longest.inspect}"
