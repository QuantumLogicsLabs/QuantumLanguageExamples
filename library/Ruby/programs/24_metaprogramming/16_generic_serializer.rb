# Serialising any object through its instance variables.
module Serializable
  def to_h
    instance_variables.to_h do |iv|
      value = instance_variable_get(iv)
      value = value.to_h if value.respond_to?(:to_h) && value.is_a?(Serializable)
      value = value.map { |v| v.is_a?(Serializable) ? v.to_h : v } if value.is_a?(Array)
      [iv.to_s.delete("@").to_sym, value]
    end
  end

  def to_s = "#{self.class.name}#{to_h.inspect}"
end

class Address
  include Serializable
  def initialize(city, zip) = (@city, @zip = city, zip)
end

class Customer
  include Serializable
  def initialize(name, address, orders) = (@name, @address, @orders = name, address, orders)
end

class Order
  include Serializable
  def initialize(id, total) = (@id, @total = id, total)
end

c = Customer.new("Ana", Address.new("Lima", "15001"), [Order.new(1, 9.5), Order.new(2, 20)])
puts c.to_h.inspect
puts Address.new("Oslo", "0150")
puts c.to_h[:orders].sum { |o| o[:total] }
