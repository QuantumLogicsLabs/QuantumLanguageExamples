# A vending machine with coins, stock and change.
class VendingMachine
  PRODUCTS = { "A1" => ["Cola", 125, 2], "A2" => ["Chips", 90, 0], "B1" => ["Candy", 65, 5] }.freeze
  COINS = [100, 25, 10, 5].freeze

  def initialize
    @stock = PRODUCTS.transform_values(&:last)
    @inserted = 0
  end

  def insert(coin)
    return "rejected #{coin}c" unless COINS.include?(coin)
    @inserted += coin
    "credit #{@inserted}c"
  end

  def select(code)
    name, price, = PRODUCTS[code] || (return "unknown #{code}")
    return "#{name} sold out" if @stock[code].zero?
    return "#{name} costs #{price}c, insert #{price - @inserted}c more" if @inserted < price
    @stock[code] -= 1
    change = make_change(@inserted - price)
    @inserted = 0
    "dispensed #{name}, change #{change.inspect}"
  end

  def refund = (c = make_change(@inserted); @inserted = 0; "refund #{c.inspect}")

  private

  def make_change(amount) = COINS.each_with_object([]) { |c, out| (amount / c).times { out << c }; amount %= c }
end

vm = VendingMachine.new
actions = [[:insert, 100], [:select, "A1"], [:insert, 50], [:select, "A1"], [:select, "A2"], [:insert, 3],
           [:insert, 25], [:select, "B1"], [:select, "C9"], [:insert, 100], [:insert, 100], [:select, "A1"],
           [:insert, 10], [:refund]]
actions.each { |a, arg| puts "#{a} #{arg}: #{arg ? vm.public_send(a, arg) : vm.public_send(a)}" }
