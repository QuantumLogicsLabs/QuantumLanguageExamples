# Money stored in cents, with arithmetic and allocation.
class Money
  include Comparable
  attr_reader :cents, :currency

  def initialize(cents, currency = "USD")
    @cents = cents
    @currency = currency
  end

  def self.parse(text) = new((text.delete("$,").to_f * 100).round)

  def +(other) = Money.new(cents + other.cents, currency)
  def -(other) = Money.new(cents - other.cents, currency)
  def *(factor) = Money.new((cents * factor).round, currency)
  def <=>(other) = cents <=> other.cents

  def allocate(parts)
    base, extra = cents.divmod(parts)
    Array.new(parts) { |i| Money.new(base + (i < extra ? 1 : 0), currency) }
  end

  def to_s = format("%s%d.%02d %s", cents.negative? ? "-" : "", cents.abs / 100, cents.abs % 100, currency)
end

price = Money.parse("$1,299.99")
tax = price * 0.0825
puts price
puts tax
puts price + tax
puts Money.new(1000) - Money.new(2550)
puts Money.new(1000).allocate(3).map(&:to_s).inspect
puts [Money.new(5), Money.new(500), Money.new(50)].max
