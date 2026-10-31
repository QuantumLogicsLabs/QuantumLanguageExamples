# The Burrows-Wheeler transform and its inverse.
def bwt(s)
  s += "$"
  rotations = (0...s.size).map { |i| s[i..] + s[0...i] }.sort
  rotations.map { |r| r[-1] }.join
end

def inverse_bwt(last)
  table = Array.new(last.size, "")
  last.size.times { table = table.zip(last.chars).map { |row, c| c + row }.sort }
  table.find { |row| row.end_with?("$") }.chomp("$")
end

def move_to_front(s)
  alphabet = s.chars.uniq.sort
  s.chars.map do |c|
    i = alphabet.index(c)
    alphabet.unshift(alphabet.delete_at(i))
    i
  end
end

%w[banana abracadabra mississippi].each do |w|
  t = bwt(w)
  puts "#{w} -> #{t} -> #{inverse_bwt(t)}  mtf #{move_to_front(t).inspect}"
end
