# Can a string be split into dictionary words? All the ways.
def word_break(s, dict)
  ok = Array.new(s.size + 1, false)
  ok[0] = true
  (1..s.size).each { |i| ok[i] = (0...i).any? { |j| ok[j] && dict.include?(s[j...i]) } }
  ok[s.size]
end

def all_breaks(s, dict, memo = {})
  return [""] if s.empty?
  memo[s] ||= dict.select { |w| s.start_with?(w) }.flat_map do |w|
    all_breaks(s[w.size..], dict, memo).map { |rest| rest.empty? ? w : "#{w} #{rest}" }
  end
end

dict = %w[cat cats and sand dog pine apple pen applepen pineapple]
%w[catsanddog pineapplepenapple catsandog applepenapple].each do |s|
  puts "#{s}: #{word_break(s, dict)}"
  all_breaks(s, dict).sort.each { |b| puts "  #{b}" }
end
