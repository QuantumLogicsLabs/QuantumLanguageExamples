# Finding anagrams of a pattern with a sliding window.
def anagram_starts(text, pat)
  need = pat.chars.tally
  window = Hash.new(0)
  hits = []
  text.each_char.with_index do |c, i|
    window[c] += 1
    if i >= pat.size
      out = text[i - pat.size]
      window[out] -= 1
      window.delete(out) if window[out].zero?
    end
    hits << i - pat.size + 1 if window == need
  end
  hits
end

puts anagram_starts("cbaebabacd", "abc").inspect
puts anagram_starts("abab", "ab").inspect
puts anagram_starts("forxxorfxdofr", "for").inspect
text = "listen silent enlist tinsel inlets"
starts = anagram_starts(text, "listen")
puts starts.map { |i| text[i, 6] }.inspect
