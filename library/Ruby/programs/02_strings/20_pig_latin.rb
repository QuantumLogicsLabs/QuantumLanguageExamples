# Translates sentences to Pig Latin.
VOWELS = %w[a e i o u].freeze

def pig_word(word)
  lower = word.downcase
  if VOWELS.include?(lower[0])
    result = lower + "way"
  else
    cluster = lower[/\A[^aeiou]+/]
    cluster += "u" if cluster.end_with?("q") && lower[cluster.length] == "u"
    result = lower[cluster.length..] + cluster + "ay"
  end
  word[0] =~ /[A-Z]/ ? result.capitalize : result
end

def pig_latin(sentence)
  sentence.gsub(/[A-Za-z]+/) { |w| pig_word(w) }
end

["Hello world", "The quick brown fox", "Apples are great", "Quiet please, string theory!"].each do |s|
  puts "#{s} -> #{pig_latin(s)}"
end
