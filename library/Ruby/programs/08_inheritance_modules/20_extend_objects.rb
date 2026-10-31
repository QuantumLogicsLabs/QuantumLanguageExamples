# Adding behaviour to individual objects with extend.
module Discountable
  def discounted(percent) = (price * (100 - percent) / 100.0).round(2)
end

module Giftable
  def gift_message = "A gift: #{name}"
end

Product = Struct.new(:name, :price)

book = Product.new("Ruby Book", 40)
mug = Product.new("Mug", 12)
book.extend(Discountable)
book.extend(Giftable)
mug.extend(Giftable)

puts book.discounted(25)
puts book.gift_message
puts mug.gift_message
puts mug.respond_to?(:discounted)
puts book.singleton_class.include?(Discountable)
puts book.is_a?(Discountable)
puts mug.is_a?(Discountable)
puts book.singleton_class.ancestors.take(3).inspect
