# Structs with behaviour defined in a block.
Rectangle = Struct.new(:width, :height) do
  def area = width * height
  def perimeter = 2 * (width + height)
  def square? = width == height
  def scale(f) = Rectangle.new(width * f, height * f)
  def to_s = "#{width}x#{height}"
end

rects = [Rectangle.new(3, 4), Rectangle.new(5, 5), Rectangle.new(2, 9)]
rects.each { |r| puts "#{r}: area #{r.area}, perimeter #{r.perimeter}, square #{r.square?}" }
puts rects.max_by(&:area)
puts rects.map { |r| r.scale(2).to_s }.inspect
puts rects.sum(&:area)
puts rects.sort_by(&:perimeter).map(&:to_s).join(" < ")

Money = Struct.new(:amount, :currency) do
  def +(other)
    raise ArgumentError, "currency mismatch" unless currency == other.currency
    Money.new(amount + other.amount, currency)
  end

  def to_s = format("%.2f %s", amount, currency)
end
puts Money.new(10.5, "EUR") + Money.new(2.25, "EUR")
