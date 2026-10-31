# Characters, codes and bytes.
word = "Ruby!"
word.each_char { |c| puts "#{c} => #{c.ord}" }
puts word.bytes.inspect
puts word.bytes.sum
puts [72, 105, 33].map(&:chr).join
puts ("a".."e").map(&:ord).inspect
puts ("A".ord + 25).chr
puts "z".succ
puts "az".next
puts "Zz".succ
alphabet = ("a".."z").to_a.join
puts alphabet
puts alphabet.upcase.each_char.each_slice(13).map(&:join).inspect
