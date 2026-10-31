# Longest repeated substring, by sorting suffixes.
def longest_repeat(s)
  suffixes = (0...s.size).map { |i| s[i..] }.sort
  best = ""
  suffixes.each_cons(2) do |a, b|
    k = 0
    k += 1 while k < a.size && k < b.size && a[k] == b[k]
    best = a[0, k] if k > best.size
  end
  best
end

def longest_non_overlapping_repeat(s)
  (s.size / 2).downto(1) do |len|
    (0..s.size - 2 * len).each do |i|
      sub = s[i, len]
      return sub if s.index(sub, i + len)
    end
  end
  ""
end

%w[banana abcabcabc mississippi aaaa abcdefg geeksforgeeks].each do |w|
  puts "#{w}: repeat #{longest_repeat(w).inspect}, non-overlapping #{longest_non_overlapping_repeat(w).inspect}"
end
