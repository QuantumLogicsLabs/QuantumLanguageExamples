# Value objects that validate on creation.
Email = Data.define(:address) do
  def initialize(address:)
    raise ArgumentError, "invalid email: #{address}" unless address.match?(/\A[^@\s]+@[^@\s]+\z/)
    super(address: address.downcase)
  end

  def domain = address.split("@").last
end

Percentage = Data.define(:value) do
  def initialize(value:)
    raise RangeError, "#{value} not in 0..100" unless (0..100).cover?(value)
    super
  end

  def of(n) = n * value / 100.0
end

%w[Ana@Example.COM bad.address x@y].each do |s|
  e = Email.new(s)
  puts "#{e.address} (#{e.domain})"
rescue ArgumentError => err
  puts err.message
end
[15, 150, 0].each do |v|
  puts "#{v}% of 80 = #{Percentage.new(v).of(80)}"
rescue RangeError => err
  puts err.message
end
