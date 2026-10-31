# The look-and-say sequence.
def look_and_say(s) = s.chars.chunk_while { |a, b| a == b }.map { |run| "#{run.size}#{run[0]}" }.join

seq = ["1"]
9.times { seq << look_and_say(seq.last) }
seq.each_with_index { |s, i| puts "#{(i + 1).to_s.rjust(2)}: #{s}" }

lengths = ["1"]
40.times { lengths << look_and_say(lengths.last) }
ratio = lengths[-1].length.fdiv(lengths[-2].length)
puts "length of term 41: #{lengths.last.length}, growth ratio #{ratio.round(5)} (Conway: 1.30358)"
puts look_and_say("3333221")
