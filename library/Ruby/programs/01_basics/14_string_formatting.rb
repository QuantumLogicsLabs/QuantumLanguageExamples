# format, % and padding helpers.
items = [["Coffee", 3, 2.5], ["Bagel", 2, 1.75], ["Juice", 1, 3.2]]

puts format("%-10s %3s %8s", "Item", "Qty", "Total")
items.each do |name, qty, price|
  puts format("%-10s %3d %8.2f", name, qty, qty * price)
end
total = items.sum { |_, q, p| q * p }
puts format("%-10s %12.2f", "TOTAL", total)

puts "%05d|%x|%o|%b" % [42, 255, 8, 5]
puts "%.3e" % 123456.789
puts "%+d %+d" % [5, -5]
puts "%-6s|%6s|" % ["ab", "cd"]
puts "%s scored %d%%" % ["Kim", 87]
puts "Pi is roughly %.4f" % Math::PI
