# String recursion: reverse, palindromes, counting.
def reverse(s) = s.empty? ? "" : reverse(s[1..]) + s[0]
def palindrome?(s) = s.length < 2 || (s[0] == s[-1] && palindrome?(s[1..-2]))
def count_char(s, c) = s.empty? ? 0 : (s[0] == c ? 1 : 0) + count_char(s[1..], c)
def remove_duplicates(s) = s.length < 2 ? s : (s[0] == s[1] ? remove_duplicates(s[1..]) : s[0] + remove_duplicates(s[1..]))

def interleavings(a, b)
  return [a + b] if a.empty? || b.empty?
  interleavings(a[1..], b).map { |x| a[0] + x } + interleavings(a, b[1..]).map { |x| b[0] + x }
end

puts reverse("recursion")
%w[racecar level ruby a abba abca].each { |w| puts "#{w}: #{palindrome?(w)}" }
puts count_char("mississippi", "s")
puts remove_duplicates("aaabccddddde")
puts interleavings("ab", "12").inspect
