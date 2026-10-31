# Longest substring without repeating characters.
def longest_unique(s)
  last = {}
  start = 0
  best = [0, 0]
  s.each_char.with_index do |c, i|
    start = last[c] + 1 if last.key?(c) && last[c] >= start
    last[c] = i
    best = [start, i + 1] if i + 1 - start > best[1] - best[0]
  end
  s[best[0]...best[1]]
end

def longest_with_k_distinct(s, k)
  counts = Hash.new(0)
  left = 0
  best = ""
  s.each_char.with_index do |c, right|
    counts[c] += 1
    while counts.size > k
      counts[s[left]] -= 1
      counts.delete(s[left]) if counts[s[left]].zero?
      left += 1
    end
    best = s[left..right] if right - left + 1 > best.size
  end
  best
end

%w[abcabcbb bbbbb pwwkew dvdf abba].each { |w| puts "#{w}: #{longest_unique(w).inspect}" }
puts longest_with_k_distinct("eceba", 2).inspect
puts longest_with_k_distinct("aabacbebebe", 3).inspect
