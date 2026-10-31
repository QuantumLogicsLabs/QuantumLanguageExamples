# The Vigenere cipher and a key-length hint from repeated trigrams.
def vigenere(text, key, direction = 1)
  shifts = key.upcase.chars.map { |c| c.ord - 65 }
  i = -1
  text.upcase.gsub(/[A-Z]/) do |c|
    i += 1
    ((c.ord - 65 + direction * shifts[i % shifts.size]) % 26 + 65).chr
  end
end

plain = "ATTACK AT DAWN THE ATTACK IS AT DAWN"
key = "LEMON"
secret = vigenere(plain, key)
puts secret
puts vigenere(secret, key, -1)

letters = secret.delete(" ")
repeats = (0..letters.size - 3).group_by { |i| letters[i, 3] }.select { |_, pos| pos.size > 1 }
repeats.each { |tri, pos| puts "#{tri} at #{pos.inspect}, distances #{pos.each_cons(2).map { |a, b| b - a }.inspect}" }
