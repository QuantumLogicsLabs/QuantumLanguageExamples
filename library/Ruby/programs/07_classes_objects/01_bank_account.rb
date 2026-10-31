# A bank account with a transaction history.
class BankAccount
  attr_reader :owner, :balance

  def initialize(owner, balance = 0)
    @owner = owner
    @balance = balance
    @history = []
  end

  def deposit(amount)
    raise ArgumentError, "deposit must be positive" unless amount.positive?
    @balance += amount
    @history << [:deposit, amount]
    self
  end

  def withdraw(amount)
    if amount > @balance
      @history << [:refused, amount]
      return false
    end
    @balance -= amount
    @history << [:withdraw, amount]
    true
  end

  def statement
    @history.map { |kind, amt| "#{kind.to_s.ljust(8)} #{amt.to_s.rjust(6)}" }
  end

  def to_s = "#{owner}: #{format('%.2f', balance)}"
end

acct = BankAccount.new("Ana", 100)
acct.deposit(50).deposit(25)
puts acct.withdraw(300)
puts acct.withdraw(60)
puts acct.statement
puts acct
begin
  acct.deposit(-5)
rescue ArgumentError => e
  puts "Error: #{e.message}"
end
