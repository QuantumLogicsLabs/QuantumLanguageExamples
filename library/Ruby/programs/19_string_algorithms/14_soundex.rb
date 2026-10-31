# Soundex codes for matching similar-sounding names.
CODES = { "bfpv" => "1", "cgjkqsxz" => "2", "dt" => "3", "l" => "4", "mn" => "5", "r" => "6" }
        .flat_map { |letters, d| letters.chars.map { |c| [c, d] } }.to_h.freeze

def soundex(name)
  s = name.downcase.delete("^a-z")
  first = s[0]
  digits = []
  prev = CODES[first]
  s[1..].each_char do |c|
    code = CODES[c]
    if code && code != prev
      digits << code
    end
    prev = code unless %w[h w].include?(c)
  end
  (first.upcase + digits.join + "000")[0, 4]
end

names = %w[Robert Rupert Rubin Ashcraft Ashcroft Tymczak Pfister Honeyman Smith Smyth Schmidt Lee Li]
names.each { |n| puts "#{n.ljust(9)} #{soundex(n)}" }
groups = names.group_by { |n| soundex(n) }.select { |_, ns| ns.size > 1 }
puts groups.inspect
