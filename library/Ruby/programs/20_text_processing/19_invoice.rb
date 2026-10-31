# Generating a formatted invoice.
Line = Struct.new(:description, :qty, :unit_price) do
  def total = qty * unit_price
end

lines = [
  Line.new("Website design", 1, 1200.0),
  Line.new("Hosting (months)", 12, 15.5),
  Line.new("Domain name", 2, 12.99),
  Line.new("Support hours", 6.5, 80.0)
]
subtotal = lines.sum(&:total)
tax = (subtotal * 0.2).round(2)

fmt = ->(x) { int, frac = format("%.2f", x).split("."); int.reverse.scan(/\d{1,3}/).join(",").reverse + "." + frac }

puts <<~HEAD
  INVOICE #2024-017
  Bill to: Acme Ltd.
  #{'-' * 52}
HEAD
puts format("%-22s %6s %10s %11s", "Description", "Qty", "Unit", "Amount")
lines.each { |l| puts format("%-22s %6s %10s %11s", l.description, l.qty, fmt.(l.unit_price), fmt.(l.total)) }
puts "-" * 52
puts format("%41s %10s", "Subtotal", fmt.(subtotal))
puts format("%41s %10s", "VAT 20%", fmt.(tax))
puts format("%41s %10s", "TOTAL", fmt.(subtotal + tax))
puts "Large amount: #{fmt.(1_234_567.891)}"
