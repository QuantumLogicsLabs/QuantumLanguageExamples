# The Z-array and pattern matching with it.
def z_array(s)
  n = s.size
  z = Array.new(n, 0)
  l = r = 0
  (1...n).each do |i|
    z[i] = [r - i, z[i - l]].min if i < r
    z[i] += 1 while i + z[i] < n && s[z[i]] == s[i + z[i]]
    l, r = i, i + z[i] if i + z[i] > r
  end
  z[0] = n
  z
end

def z_search(text, pat)
  z = z_array(pat + "\u0000" + text)
  (pat.size + 1...z.size).select { |i| z[i] >= pat.size }.map { |i| i - pat.size - 1 }
end

puts z_array("aabcaabxaaaz").inspect
puts z_array("aaaaa").inspect
puts z_search("baabaa", "aab").inspect
puts z_search("abracadabra", "abra").inspect
period = ->(s) { (1..s.size).find { |p| (s.size % p).zero? && z_array(s + s)[p] >= s.size } }
%w[abcabcabc abab aaaa abcd].each { |s| puts "#{s}: smallest period #{period.(s)}" }
