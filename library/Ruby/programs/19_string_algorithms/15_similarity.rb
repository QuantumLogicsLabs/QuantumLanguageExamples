# Hamming distance and Jaro-Winkler similarity.
def hamming(a, b) = a.chars.zip(b.chars).count { |x, y| x != y }

def jaro(a, b)
  return 1.0 if a == b
  window = [[a.size, b.size].max / 2 - 1, 0].max
  am = Array.new(a.size, false)
  bm = Array.new(b.size, false)
  matches = 0
  a.each_char.with_index do |c, i|
    lo, hi = [0, i - window].max, [b.size - 1, i + window].min
    (lo..hi).each do |j|
      next if bm[j] || b[j] != c
      am[i] = bm[j] = true
      matches += 1
      break
    end
  end
  return 0.0 if matches.zero?
  ac = a.chars.select.with_index { |_, i| am[i] }
  bc = b.chars.select.with_index { |_, i| bm[i] }
  t = ac.zip(bc).count { |x, y| x != y } / 2.0
  (matches.fdiv(a.size) + matches.fdiv(b.size) + (matches - t) / matches) / 3
end

def jaro_winkler(a, b)
  j = jaro(a, b)
  prefix = a.chars.zip(b.chars).take_while { |x, y| x == y }.size.clamp(0, 4)
  j + prefix * 0.1 * (1 - j)
end

puts hamming("karolin", "kathrin"), hamming("1011101", "1001001")
[%w[MARTHA MARHTA], %w[DWAYNE DUANE], %w[DIXON DICKSONX], %w[ruby rubies], %w[abc xyz]].each do |a, b|
  puts format("%-8s %-9s jaro %.4f  jaro-winkler %.4f", a, b, jaro(a, b), jaro_winkler(a, b))
end
