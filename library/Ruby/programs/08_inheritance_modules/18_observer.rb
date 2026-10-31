# A hand-written observer pattern.
module Observable
  def observers = @observers ||= []
  def subscribe(callable = nil, &block) = observers << (callable || block)
  def notify(*args) = observers.each { |o| o.call(*args) }
end

class StockTicker
  include Observable
  attr_reader :prices

  def initialize = @prices = {}

  def update(symbol, price)
    old = prices[symbol]
    prices[symbol] = price
    notify(symbol, old, price) if old && old != price
  end
end

alerts = []
ticker = StockTicker.new
ticker.subscribe { |sym, old, new| puts "#{sym}: #{old} -> #{new}" }
ticker.subscribe(->(sym, old, new) { alerts << sym if (new - old).abs / old > 0.05 })

[["ACME", 100.0], ["INIT", 50.0], ["ACME", 101.5], ["INIT", 46.0], ["ACME", 101.5], ["ACME", 108.0]].each do |s, p|
  ticker.update(s, p)
end
puts "Big moves: #{alerts.inspect}"
puts ticker.prices.inspect
