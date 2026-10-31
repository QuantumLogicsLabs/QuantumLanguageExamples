# Roman numerals in both directions.
ROMAN = { 1000 => "M", 900 => "CM", 500 => "D", 400 => "CD", 100 => "C", 90 => "XC",
          50 => "L", 40 => "XL", 10 => "X", 9 => "IX", 5 => "V", 4 => "IV", 1 => "I" }.freeze
VALUES = { "I" => 1, "V" => 5, "X" => 10, "L" => 50, "C" => 100, "D" => 500, "M" => 1000 }.freeze

def to_roman(n)
  ROMAN.reduce(+"") do |out, (value, letters)|
    count, n = n.divmod(value)
    out << letters * count
  end
end

def from_roman(s)
  values = s.chars.map { |c| VALUES[c] }
  values.each_with_index.sum { |v, i| values[i + 1] && values[i + 1] > v ? -v : v }
end

[1, 4, 9, 14, 40, 90, 400, 1987, 2024, 3999].each do |n|
  r = to_roman(n)
  puts "#{n.to_s.rjust(4)} = #{r.ljust(12)} back: #{from_roman(r)}"
end
