# The longest dictionary words that can be built from a rack of letters.
DICTIONARY = %w[ruby rub bury tube brute butter rubble tribe bite tire rite tier write writer berry
                trouble outer route router tour turbo robe bore orbit tribute].freeze

def buildable?(word, rack)
  available = rack.chars.tally
  word.chars.tally.all? { |ch, n| available.fetch(ch, 0) >= n }
end

def best_words(rack)
  DICTIONARY.select { |w| buildable?(w, rack) }.sort_by { |w| [-w.size, w] }
end

%w[rubtoeri trbuyeor ttribue].each do |rack|
  words = best_words(rack)
  puts "#{rack}: #{words.first(5).inspect} (#{words.size} words)"
end
letter_values = ("a".."z").zip([1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10]).to_h
best = best_words("trbuyeor").max_by { |w| [w.chars.sum { |c| letter_values[c] }, w] }
puts "highest scoring from trbuyeor: #{best} (#{best.chars.sum { |c| letter_values[c] }} points)"
