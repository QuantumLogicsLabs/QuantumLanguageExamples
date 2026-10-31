# Merging hashes, with and without conflict blocks.
defaults = { color: "blue", size: "M", gift_wrap: false }
order = { size: "L", gift_wrap: true, note: "fragile" }

puts defaults.merge(order).inspect
puts order.merge(defaults).inspect

stock_a = { "pens" => 10, "ink" => 3 }
stock_b = { "pens" => 5, "paper" => 100 }
combined = stock_a.merge(stock_b) { |_key, a, b| a + b }
puts combined.inspect

totals = {}
[{ "x" => 1 }, { "y" => 2, "x" => 3 }, { "z" => 4, "y" => 1 }].each do |h|
  totals.update(h) { |_, old, new| old + new }
end
puts totals.inspect

base = { a: 1 }
base.merge!(b: 2)
puts base.inspect
puts({ a: { x: 1 } }.merge({ a: { y: 2 } }) { |_, l, r| l.merge(r) }.inspect)
