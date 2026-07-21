# Demonstrates a classic race condition (read-modify-write on shared
# state without synchronization) and its fix using a Mutex.
require 'thread'

class UnsafeAccount
  attr_reader :balance
  def initialize(balance)
    @balance = balance
  end

  def withdraw(amount)
    return false if amount > @balance
    current = @balance
    sleep(0.0001) # simulate work, widening the race window
    @balance = current - amount
    true
  end
end

class SafeAccount
  attr_reader :balance
  def initialize(balance)
    @balance = balance
    @mutex = Mutex.new
  end

  def withdraw(amount)
    @mutex.synchronize do
      return false if amount > @balance
      current = @balance
      sleep(0.0001)
      @balance = current - amount
      true
    end
  end
end

def run_concurrent_withdrawals(account)
  threads = Array.new(10) { Thread.new { account.withdraw(10) } }
  threads.each(&:join)
  account.balance
end

if __FILE__ == $0
  unsafe = UnsafeAccount.new(100)
  final_unsafe = run_concurrent_withdrawals(unsafe)
  puts "Unsafe account: expected 0, got #{final_unsafe} (race condition may cause an incorrect result)"

  safe = SafeAccount.new(100)
  final_safe = run_concurrent_withdrawals(safe)
  puts "Safe account (mutex-protected): expected 0, got #{final_safe}"
end
