# Boyer-Moore-Horspool search with the bad-character shift table.
def horspool(text, pat)
  m = pat.size
  shift = Hash.new(m)
  pat[0...-1].each_char.with_index { |c, i| shift[c] = m - 1 - i }
  hits = []
  i = 0
  comparisons = 0
  while i <= text.size - m
    j = m - 1
    j -= 1 while j >= 0 && (comparisons += 1) && text[i + j] == pat[j]
    hits << i if j.negative?
    i += shift[text[i + m - 1]]
  end
  [hits, comparisons, shift.sort.to_h]
end

text = "WHICH FINALLY HALTS.  AT THAT POINT THAT IS THE END"
hits, comps, table = horspool(text, "THAT")
puts "hits #{hits.inspect}, #{comps} character comparisons"
puts "shift table: #{table.inspect}"
puts horspool("GCATCGCAGAGAGTATACAGTACG", "GCAGAGAG").first.inspect
