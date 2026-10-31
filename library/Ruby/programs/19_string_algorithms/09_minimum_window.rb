# The smallest window of a string containing all letters of another.
def min_window(s, t)
  need = t.chars.tally
  missing = t.size
  best = nil
  left = 0
  s.each_char.with_index do |c, right|
    if need.key?(c)
      missing -= 1 if need[c].positive?
      need[c] -= 1
    end
    while missing.zero?
      best = [left, right] if best.nil? || right - left < best[1] - best[0]
      lc = s[left]
      if need.key?(lc)
        need[lc] += 1
        missing += 1 if need[lc].positive?
      end
      left += 1
    end
  end
  best ? s[best[0]..best[1]] : ""
end

[%w[ADOBECODEBANC ABC], %w[a a], %w[a aa], %w[thisisateststring tist], %w[geeksforgeeks ork]].each do |s, t|
  puts "#{s} / #{t}: #{min_window(s, t).inspect}"
end
