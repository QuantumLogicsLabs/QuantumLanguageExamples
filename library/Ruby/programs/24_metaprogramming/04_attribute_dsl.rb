# A class-level DSL for typed attributes with defaults.
module Attributes
  def attribute(name, type, default: nil)
    attributes[name] = [type, default]
    define_method(name) { @values.fetch(name) { default } }
    define_method("#{name}=") do |value|
      raise TypeError, "#{name} must be #{type}, got #{value.class}" unless value.is_a?(type)
      @values[name] = value
    end
  end

  def attributes = @attributes ||= {}
end

class Product
  extend Attributes
  attribute :name, String, default: "unnamed"
  attribute :price, Numeric, default: 0
  attribute :tags, Array, default: []

  def initialize(**kw)
    @values = {}
    kw.each { |k, v| public_send("#{k}=", v) }
  end

  def to_s = self.class.attributes.keys.map { |k| "#{k}=#{public_send(k).inspect}" }.join(" ")
end

puts Product.new
puts Product.new(name: "Lamp", price: 19.99, tags: ["home"])
begin
  Product.new(price: "cheap")
rescue TypeError => e
  puts "TypeError: #{e.message}"
end
puts Product.attributes.transform_values(&:first).inspect
