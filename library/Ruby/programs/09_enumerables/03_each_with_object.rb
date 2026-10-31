# Building results with each_with_object.
orders = [
  { customer: "ana", item: "pen", qty: 3 },
  { customer: "ben", item: "ink", qty: 1 },
  { customer: "ana", item: "ink", qty: 2 },
  { customer: "cy", item: "pad", qty: 5 },
  { customer: "ben", item: "pen", qty: 4 }
]

by_customer = orders.each_with_object(Hash.new(0)) { |o, h| h[o[:customer]] += o[:qty] }
puts by_customer.inspect

items = orders.each_with_object(Hash.new { |h, k| h[k] = [] }) { |o, h| h[o[:item]] << o[:customer] }
puts items.inspect

seen = orders.each_with_object(Set.new) { |o, s| s << o[:item] }
puts seen.to_a.sort.inspect

matrix = (1..3).each_with_object([]) { |r, rows| rows << (1..3).map { |c| r * c } }
puts matrix.inspect

index = %w[alpha beta gamma].each_with_index.each_with_object({}) { |(w, i), h| h[w[0]] = i }
puts index.inspect
