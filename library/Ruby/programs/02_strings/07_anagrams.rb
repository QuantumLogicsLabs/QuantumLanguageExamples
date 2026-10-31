# Anagram checks and grouping.
def signature(word)
  word.downcase.delete("^a-z").chars.sort.join
end

def anagram?(a, b)
  signature(a) == signature(b)
end

pairs = [["listen", "silent"], ["Dormitory", "dirty room"], ["hello", "world"], ["The eyes", "They see"]]
pairs.each { |a, b| puts "#{a} / #{b}: #{anagram?(a, b)}" }

words = %w[stop pots tops opts post spot cat act tac dog god odg bird]
groups = words.group_by { |w| signature(w) }.values.select { |g| g.size > 1 }
groups.sort_by { |g| -g.size }.each { |g| puts g.sort.join(", ") }
