# Caesar cipher: shift letters, keep case and punctuation.
def caesar(text, shift)
  text.gsub(/[a-z]/i) do |ch|
    base = ch =~ /[a-z]/ ? "a".ord : "A".ord
    ((ch.ord - base + shift) % 26 + base).chr
  end
end

message = "Attack at dawn, Brutus!"
secret = caesar(message, 3)
puts "Plain:     #{message}"
puts "Encrypted: #{secret}"
puts "Decrypted: #{caesar(secret, -3)}"
puts "ROT13:     #{caesar(message, 13)}"
puts "ROT13 x2:  #{caesar(caesar(message, 13), 13)}"

puts "Brute force of 'Khoor':"
(1..5).each { |k| puts "  shift #{k}: #{caesar('Khoor', -k)}" }
