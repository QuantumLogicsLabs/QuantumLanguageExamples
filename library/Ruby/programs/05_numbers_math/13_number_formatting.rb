# Thousands separators, percentages and currency.
def with_commas(n)
  int, frac = n.to_s.split(".")
  int = int.reverse.scan(/\d{1,3}/).join(",").reverse
  int = "-" + int if n.negative?
  frac ? "#{int}.#{frac}" : int
end

[0, 999, 1000, 1234567, -9876543, 1234567.891].each { |n| puts with_commas(n) }

def money(amount)
  whole, cents = format("%.2f", amount).split(".")
  "$#{with_commas(whole.to_i)}.#{cents}"
end

puts money(1234.5)
puts money(1_000_000)
puts format("%.1f%%", 0.4567 * 100)
puts (1234567.891).floor(-3)
puts 1234567.to_s.rjust(12, "0")
puts 3.14159.to_s[0, 4]
