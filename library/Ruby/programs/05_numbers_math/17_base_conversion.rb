# Converting bases by hand.
DIGITS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"

def to_base(n, base)
  return "0" if n.zero?
  out = +""
  neg = n.negative?
  n = n.abs
  while n.positive?
    n, r = n.divmod(base)
    out.prepend(DIGITS[r])
  end
  neg ? "-" + out : out
end

def from_base(s, base)
  s.upcase.chars.reduce(0) { |acc, ch| acc * base + DIGITS.index(ch) }
end

[[255, 2], [255, 16], [1000, 7], [-42, 3], [123456789, 36], [0, 5]].each do |n, b|
  s = to_base(n, b)
  check = n.negative? ? -from_base(s[1..], b) : from_base(s, b)
  puts "#{n} in base #{b}: #{s} (back #{check}, Ruby #{n.to_s(b).upcase})"
end
