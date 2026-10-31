# Palindrome detection on phrases, ignoring case and punctuation.
def normalize(text)
  text.downcase.gsub(/[^a-z0-9]/, "")
end

def palindrome?(text)
  clean = normalize(text)
  clean == clean.reverse
end

phrases = [
  "A man, a plan, a canal: Panama",
  "racecar",
  "Was it a car or a cat I saw?",
  "No lemon, no melon",
  "Hello, world",
  "Step on no pets",
  "Ruby"
]

phrases.each do |p|
  puts "#{palindrome?(p) ? 'YES' : 'no '}  #{p}"
end

words = %w[level noon kayak ruby civic python refer]
puts "Palindromic words: #{words.select { |w| palindrome?(w) }.join(', ')}"
