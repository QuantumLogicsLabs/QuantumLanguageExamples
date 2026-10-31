# Finding all occurrences of a pattern, naively and with String#index.
def naive_find_all(text, pat)
  (0..text.length - pat.length).select { |i| text[i, pat.length] == pat }
end

def index_find_all(text, pat)
  out = []
  i = text.index(pat)
  while i
    out << i
    i = text.index(pat, i + 1)
  end
  out
end

text = "abracadabra abracadabra"
%w[abra cad a ra zz].each do |pat|
  naive = naive_find_all(text, pat)
  puts "#{pat.ljust(4)} #{naive.inspect} #{naive == index_find_all(text, pat) ? 'ok' : 'MISMATCH'}"
end
puts text.scan(/(?=abra)/).size
puts text.enum_for(:scan, /a/).map { Regexp.last_match.begin(0) }.inspect
