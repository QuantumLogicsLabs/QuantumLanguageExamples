# A shopping cart with discounts.
class Item
  attr_reader :name, :price, :qty
  def initialize(name, price, qty = 1) = (@name, @price, @qty = name, price, qty)
  def total = price * qty
end

class Cart
  def initialize = @items = []

  def add(name, price, qty = 1)
    existing = @items.find { |i| i.name == name }
    if existing
      @items.delete(existing)
      qty += existing.qty
    end
    @items << Item.new(name, price, qty)
    self
  end

  def subtotal = @items.sum(&:total)

  def discount
    bulk = @items.select { |i| i.qty >= 3 }.sum { |i| i.total * 0.1 }
    bulk + (subtotal > 100 ? 5 : 0)
  end

  def receipt
    lines = @items.map { |i| format("%-10s %2d x %6.2f = %7.2f", i.name, i.qty, i.price, i.total) }
    lines << format("%-23s %7.2f", "Subtotal", subtotal)
    lines << format("%-23s %7.2f", "Discount", -discount)
    lines << format("%-23s %7.2f", "Total", subtotal - discount)
  end
end

cart = Cart.new
cart.add("Notebook", 4.5, 2).add("Pen", 1.25, 4).add("Backpack", 79.99).add("Notebook", 4.5)
puts cart.receipt
