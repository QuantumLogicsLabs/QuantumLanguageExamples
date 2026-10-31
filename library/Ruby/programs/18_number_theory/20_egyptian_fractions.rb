# Greedy Egyptian fraction decompositions.
def egyptian(r)
  parts = []
  while r.positive?
    d = (1 / r).ceil
    parts << d
    r -= Rational(1, d)
  end
  parts
end

[Rational(4, 13), Rational(5, 6), Rational(7, 15), Rational(2, 3), Rational(3, 7), Rational(5, 121)].each do |r|
  ds = egyptian(r)
  puts "#{r} = #{ds.map { |d| "1/#{d}" }.join(' + ')}"
  raise "bad sum" unless ds.sum { |d| Rational(1, d) } == r
end
