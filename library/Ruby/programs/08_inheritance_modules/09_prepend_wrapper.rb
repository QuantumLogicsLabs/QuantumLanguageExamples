# Using prepend to add logging around existing methods.
module CallLog
  def self.entries = @entries ||= []

  def deposit(amount)
    CallLog.entries << "deposit(#{amount})"
    result = super
    CallLog.entries << "  -> balance #{result}"
    result
  end
end

class Wallet
  prepend CallLog
  def initialize = @balance = 0
  def deposit(amount) = @balance += amount
end

w = Wallet.new
w.deposit(10)
w.deposit(25)
puts CallLog.entries
puts Wallet.ancestors.first(2).inspect
