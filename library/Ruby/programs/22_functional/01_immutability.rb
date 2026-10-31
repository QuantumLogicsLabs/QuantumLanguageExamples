# Pure functions and immutable updates.
def add_item(cart, item) = cart + [item]
def update_qty(cart, name, qty) = cart.map { |i| i[:name] == name ? i.merge(qty: qty) : i }
def remove_item(cart, name) = cart.reject { |i| i[:name] == name }
def total(cart) = cart.sum { |i| i[:qty] * i[:price] }

empty = [].freeze
c1 = add_item(empty, { name: "tea", qty: 1, price: 4.5 }.freeze)
c2 = add_item(c1, { name: "mug", qty: 2, price: 7.0 }.freeze)
c3 = update_qty(c2, "tea", 3)
c4 = remove_item(c3, "mug")

[empty, c1, c2, c3, c4].each_with_index do |c, i|
  puts "v#{i}: #{c.map { |x| "#{x[:name]}x#{x[:qty]}" }.inspect} total #{total(c)}"
end
puts c2.equal?(c3)
puts c2[0].equal?(c3[1])
puts c2[1].equal?(c3[1])
puts empty.frozen?, c1.first.frozen?
