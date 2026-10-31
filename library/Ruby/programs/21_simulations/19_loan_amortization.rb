# A loan amortization schedule.
principal = 20_000.0
annual_rate = 0.06
months = 24
r = annual_rate / 12
payment = principal * r / (1 - (1 + r)**-months)

puts format("monthly payment: %.2f", payment)
balance = principal
total_interest = 0.0
puts "month  interest  principal   balance"
(1..months).each do |m|
  interest = balance * r
  paid = payment - interest
  balance -= paid
  total_interest += interest
  puts format("%5d %9.2f %10.2f %9.2f", m, interest, paid, balance.abs) if m <= 3 || m > months - 3 || (m % 6).zero?
end
puts format("total interest: %.2f", total_interest)
puts format("total paid: %.2f", payment * months)
