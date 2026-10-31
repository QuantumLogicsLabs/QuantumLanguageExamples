# Manacher's algorithm for the longest palindromic substring.
def manacher(s)
  t = '^#' + s.chars.join('#') + '#$'
  p = Array.new(t.size, 0)
  center = right = 0
  (1...t.size - 1).each do |i|
    p[i] = [right - i, p[2 * center - i]].min if i < right
    p[i] += 1 while t[i + p[i] + 1] == t[i - p[i] - 1]
    center, right = i, i + p[i] if i + p[i] > right
  end
  len, mid = p.each_with_index.max
  s[(mid - len) / 2, len]
end

def count_palindromic_substrings(s)
  (0...s.size).sum do |c|
    [[c, c], [c, c + 1]].sum do |l, r|
      n = 0
      while l >= 0 && r < s.size && s[l] == s[r]
        n += 1
        l -= 1
        r += 1
      end
      n
    end
  end
end

%w[babad cbbd forgeeksskeegfor abacdfgdcaba a racecarxyz].each do |w|
  puts "#{w}: #{manacher(w).inspect}, #{count_palindromic_substrings(w)} palindromic substrings"
end
