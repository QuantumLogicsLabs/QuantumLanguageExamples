# Structs with defaults through a custom initializer.
Order = Struct.new(:id, :items, :status, :priority) do
  def initialize(id, items = [], status = :new, priority = :normal)
    super
  end

  def total = items.sum { |_, price, qty| price * qty }
  def express? = priority == :high
end

orders = [
  Order.new(1, [["pen", 1.5, 4], ["pad", 3.0, 1]]),
  Order.new(2, [["ink", 12.0, 2]], :shipped, :high),
  Order.new(3)
]
orders.each do |o|
  puts "##{o.id} #{o.status} #{o.priority} items=#{o.items.size} total=#{o.total} express=#{o.express?}"
end
orders[2].items << ["clip", 0.1, 50]
orders[2].status = :packed
puts orders[2].to_a.inspect
puts orders.sum(&:total).round(2)
