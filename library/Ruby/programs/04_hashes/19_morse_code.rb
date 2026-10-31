# Morse code encoder and decoder.
MORSE = {
  "A" => ".-", "B" => "-...", "C" => "-.-.", "D" => "-..", "E" => ".", "F" => "..-.", "G" => "--.",
  "H" => "....", "I" => "..", "J" => ".---", "K" => "-.-", "L" => ".-..", "M" => "--", "N" => "-.",
  "O" => "---", "P" => ".--.", "Q" => "--.-", "R" => ".-.", "S" => "...", "T" => "-", "U" => "..-",
  "V" => "...-", "W" => ".--", "X" => "-..-", "Y" => "-.--", "Z" => "--..",
  "1" => ".----", "2" => "..---", "3" => "...--", "0" => "-----"
}.freeze
DECODE = MORSE.invert.freeze

def encode(text)
  text.upcase.split.map { |word| word.chars.map { |c| MORSE.fetch(c, "?") }.join(" ") }.join(" / ")
end

def decode(code)
  code.split(" / ").map { |word| word.split.map { |sym| DECODE.fetch(sym, "?") }.join }.join(" ")
end

["SOS", "Hello World", "Ruby 2023"].each do |msg|
  code = encode(msg)
  puts "#{msg} -> #{code}"
  puts "  back: #{decode(code)}"
end
puts "Longest code: #{MORSE.max_by { |_, c| [c.length, c] }.inspect}"
