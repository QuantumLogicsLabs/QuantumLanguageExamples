# Class methods, class-level counters and factories.
class Ticket
  @@issued = 0
  PRICES = { adult: 12, child: 6, senior: 8 }.freeze

  attr_reader :number, :kind

  def self.issued = @@issued

  def self.family(adults, children)
    Array.new(adults) { new(:adult) } + Array.new(children) { new(:child) }
  end

  def initialize(kind)
    @@issued += 1
    @number = @@issued
    @kind = kind
  end

  def price = PRICES.fetch(kind)
  def to_s = "##{number} #{kind} $#{price}"
end

single = Ticket.new(:senior)
family = Ticket.family(2, 3)
puts single
family.each { |t| puts t }
puts "Tickets issued: #{Ticket.issued}"
puts "Family total: $#{family.sum(&:price)}"
puts Ticket.respond_to?(:family)
puts single.respond_to?(:family)
