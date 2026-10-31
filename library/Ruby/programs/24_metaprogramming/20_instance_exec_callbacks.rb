# Before and after callbacks run with instance_exec.
module Callbacks
  def self.included(base) = base.extend(ClassMethods)

  module ClassMethods
    def callbacks = @callbacks ||= Hash.new { |h, k| h[k] = [] }
    def before(action, &block) = callbacks[[:before, action]] << block
    def after(action, &block) = callbacks[[:after, action]] << block
  end

  def run(action, *args)
    self.class.callbacks[[:before, action]].each { |cb| instance_exec(*args, &cb) }
    result = public_send(action, *args)
    self.class.callbacks[[:after, action]].each { |cb| instance_exec(result, &cb) }
    result
  end
end

class Account
  include Callbacks
  attr_reader :balance, :log

  def initialize = (@balance = 100; @log = [])

  before(:withdraw) { |amount| @log << "checking #{amount} against #{@balance}" }
  before(:withdraw) { |amount| raise ArgumentError, "insufficient funds" if amount > @balance }
  after(:withdraw) { |result| @log << "balance now #{result}" }

  def withdraw(amount) = @balance -= amount
end

acct = Account.new
acct.run(:withdraw, 30)
begin
  acct.run(:withdraw, 500)
rescue ArgumentError => e
  acct.log << "refused: #{e.message}"
end
acct.run(:withdraw, 20)
puts acct.log
puts acct.balance
