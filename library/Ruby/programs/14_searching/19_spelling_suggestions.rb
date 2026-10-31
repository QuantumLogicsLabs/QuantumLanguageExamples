# Suggesting words by edit distance.
def distance(a, b)
  prev = (0..b.size).to_a
  a.each_char.with_index(1) do |ca, i|
    cur = [i]
    b.each_char.with_index(1) do |cb, j|
      cur << [prev[j] + 1, cur[j - 1] + 1, prev[j - 1] + (ca == cb ? 0 : 1)].min
    end
    prev = cur
  end
  prev.last
end

DICTIONARY = %w[apple apply ample maple angle ruby rugby robe rope table cable fable label].freeze

def suggest(word, limit = 3)
  DICTIONARY.map { |w| [distance(word, w), w] }.select { |d, _| d <= 2 }.sort.first(limit).map(&:last)
end

%w[appel rubie tabel lable xyz rope].each do |w|
  s = suggest(w)
  puts "#{w}: #{s.empty? ? 'no suggestions' : s.join(', ')}"
end
