# Swapping pricing strategies at runtime.
module RegularPricing
  def self.price(base) = base
end

module SalePricing
  def self.price(base) = (base * 0.8).round(2)
end

module ClearancePricing
  def self.price(base) = [(base * 0.5).round(2), 1.0].max
end

class Product
  attr_accessor :strategy
  attr_reader :name

  def initialize(name, base, strategy = RegularPricing)
    @name, @base, @strategy = name, base, strategy
  end

  def price = strategy.price(@base)
end

products = [Product.new("Lamp", 40), Product.new("Mug", 1.5), Product.new("Desk", 250)]
[RegularPricing, SalePricing, ClearancePricing].each do |s|
  products.each { |p| p.strategy = s }
  puts "#{s.name.ljust(16)} #{products.map { |p| "#{p.name}=#{p.price}" }.join(' ')}"
end
