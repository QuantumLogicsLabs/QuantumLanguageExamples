# Suffix array (naive O(n^2 log n) sort-based construction, fine for
# teaching/small inputs) plus its companion LCP (Longest Common
# Prefix) array, the backbone of many string-matching structures.
def build_suffix_array(s)
  s += "\x00"
  n = s.length
  suffixes = (0...n).map { |i| [s[i..-1], i] }
  suffixes.sort_by! { |suffix, _| suffix }
  suffixes.map { |_, index| index }
end

def build_lcp_array(s, suffix_array)
  s += "\x00"
  n = s.length
  rank = Array.new(n)
  suffix_array.each_with_index { |suffix, i| rank[suffix] = i }

  lcp = Array.new(n, 0)
  h = 0
  (0...n).each do |i|
    next if rank[i].zero?
    j = suffix_array[rank[i] - 1]
    while i + h < n && j + h < n && s[i + h] == s[j + h]
      h += 1
    end
    lcp[rank[i]] = h
    h -= 1 if h > 0
  end
  lcp
end

if __FILE__ == $0
  s = "banana"
  sa = build_suffix_array(s)
  lcp = build_lcp_array(s, sa)
  puts "String: #{s}"
  puts "Suffix array: #{sa}"
  sa.each_with_index do |idx, i|
    suffix = (s + "$")[idx..-1]
    puts "  [#{i}] idx=#{idx} lcp=#{lcp[i]} suffix=#{suffix}"
  end
end
