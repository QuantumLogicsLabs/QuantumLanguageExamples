# Rolling back a transfer when a step fails.
class InsufficientFunds < StandardError; end
class AccountLocked < StandardError; end

Account = Struct.new(:name, :balance, :locked)

def transfer(from, to, amount, log)
  snapshot = [from.balance, to.balance]
  from.balance -= amount
  log << "debited #{from.name}"
  raise InsufficientFunds, "#{from.name} would go negative" if from.balance.negative?
  raise AccountLocked, "#{to.name} is locked" if to.locked
  to.balance += amount
  log << "credited #{to.name}"
  :committed
rescue InsufficientFunds, AccountLocked => e
  from.balance, to.balance = snapshot
  log << "rolled back: #{e.message}"
  :rolled_back
end

a = Account.new("A", 100, false)
b = Account.new("B", 50, false)
c = Account.new("C", 0, true)
[[a, b, 30], [b, a, 500], [a, c, 10], [b, a, 80]].each do |from, to, amt|
  log = []
  status = transfer(from, to, amt, log)
  puts "#{from.name}->#{to.name} #{amt}: #{status} [#{log.join('; ')}]"
end
puts [a, b, c].map { |acc| "#{acc.name}=#{acc.balance}" }.join(" ")
