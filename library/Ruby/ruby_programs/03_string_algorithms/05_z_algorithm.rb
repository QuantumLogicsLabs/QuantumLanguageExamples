# Z-algorithm: builds the Z-array (longest match with the string's own
# prefix, at every position) in O(n), then uses it for pattern matching.
def z_array(s)
  n = s.length
  z = Array.new(n, 0)
  z[0] = n
  l, r = 0, 0

  (1...n).each do |i|
    z[i] = [r - i, z[i - l]].min if i < r
    while i + z[i] < n && s[z[i]] == s[i + z[i]]
      z[i] += 1
    end
    l, r = i, i + z[i] if i + z[i] > r
  end
  z
end

def z_search(text, pattern)
  combined = pattern + "\x00" + text
  z = z_array(combined)
  matches = []
  (pattern.length + 1...combined.length).each do |i|
    matches << (i - pattern.length - 1) if z[i] >= pattern.length
  end
  matches
end

if __FILE__ == $0
  puts "Z-array of 'aabxaabxcaabxaabxay': #{z_array('aabxaabxcaabxaabxay')}"
  puts "Matches of 'aab' in 'aabxaabxcaabxaabxay': #{z_search('aabxaabxcaabxaabxay', 'aab')}"
end
