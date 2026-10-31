# Simple and compound interest over several years.
principal = 1000.0
rate = 0.05

puts "Year  Simple    Compound"
(0..5).each do |year|
  simple = principal * (1 + rate * year)
  compound = principal * (1 + rate)**year
  puts format("%4d  %8.2f  %8.2f", year, simple, compound)
end

years_to_double = 0
amount = principal
while amount < 2 * principal
  amount *= 1 + rate
  years_to_double += 1
end
puts "Doubling takes #{years_to_double} years at #{(rate * 100).to_i}%"
puts "Rule of 72 estimate: #{(72 / (rate * 100)).round(1)} years"
