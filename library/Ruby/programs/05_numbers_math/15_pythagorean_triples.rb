# Pythagorean triples, primitive ones via Euclid's formula.
def triples(limit)
  result = []
  (1..limit).each do |a|
    (a..limit).each do |b|
      c = Math.sqrt(a * a + b * b)
      result << [a, b, c.to_i] if c <= limit && c == c.floor
    end
  end
  result
end

all = triples(30)
puts "Triples up to 30: #{all.size}"
all.each { |t| puts t.inspect }

primitive = []
(2..6).each do |m|
  (1...m).each do |n|
    next unless (m - n).odd? && m.gcd(n) == 1
    primitive << [m * m - n * n, 2 * m * n, m * m + n * n].sort
  end
end
puts "Primitive (Euclid): #{primitive.sort.inspect}"
special = (1..500).to_a.combination(2).find { |a, b| c = 1000 - a - b; a * a + b * b == c * c }
puts "a + b + c = 1000: #{special.inspect}, product #{special.reduce(:*) * (1000 - special.sum)}"
