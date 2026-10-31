# Continued fractions and convergents.
def cf_of_rational(num, den)
  terms = []
  until den.zero?
    q, r = num.divmod(den)
    terms << q
    num, den = den, r
  end
  terms
end

def cf_of_sqrt(n)
  a0 = Integer.sqrt(n)
  return [a0, []] if a0 * a0 == n
  m, d, a = 0, 1, a0
  period = []
  until a == 2 * a0
    m = d * a - m
    d = (n - m * m) / d
    a = (a0 + m) / d
    period << a
  end
  [a0, period]
end

def convergents(terms)
  h1, h2, k1, k2 = 1, 0, 0, 1
  terms.map do |a|
    h1, h2 = a * h1 + h2, h1
    k1, k2 = a * k1 + k2, k1
    Rational(h1, k1)
  end
end

puts cf_of_rational(415, 93).inspect
puts cf_of_sqrt(2).inspect, cf_of_sqrt(23).inspect, cf_of_sqrt(16).inspect
a0, period = cf_of_sqrt(2)
puts convergents([a0] + period * 6).map(&:to_s).inspect
pi_terms = [3, 7, 15, 1, 292, 1, 1]
convergents(pi_terms).each { |c| puts "#{c.to_s.ljust(16)} #{c.to_f}" }
