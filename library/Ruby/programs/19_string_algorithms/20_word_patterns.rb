# Isomorphic strings, word patterns and minimal rotations.
def isomorphic?(a, b)
  return false unless a.size == b.size
  a.chars.zip(b.chars).uniq.size == a.chars.uniq.size && a.chars.uniq.size == b.chars.uniq.size
end

def pattern_of(seq) = seq.map { |x| seq.index(x) }

def matches_pattern?(pattern, sentence)
  words = sentence.split
  pattern.size == words.size && pattern_of(pattern.chars) == pattern_of(words)
end

def minimal_rotation(s) = (0...s.size).map { |i| s[i..] + s[0...i] }.min

[%w[egg add], %w[foo bar], %w[paper title], %w[ab aa]].each { |a, b| puts "#{a}/#{b}: #{isomorphic?(a, b)}" }
[["abba", "dog cat cat dog"], ["abba", "dog cat cat fish"], ["aaaa", "dog dog dog dog"], ["abc", "a b a"]].each do |p, s|
  puts "#{p} ~ '#{s}': #{matches_pattern?(p, s)}"
end
%w[bca dcba cabbage aaab].each { |s| puts "min rotation of #{s}: #{minimal_rotation(s)}" }
puts pattern_of(%w[red blue red green blue]).inspect
