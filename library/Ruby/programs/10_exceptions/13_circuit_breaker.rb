# A circuit breaker that stops calling a failing dependency.
class CircuitOpen < StandardError; end

class CircuitBreaker
  attr_reader :state

  def initialize(threshold:, cooldown:)
    @threshold, @cooldown = threshold, cooldown
    @failures = 0
    @state = :closed
    @opened_at = nil
  end

  def call(now)
    if @state == :open
      raise CircuitOpen, "open until #{@opened_at + @cooldown}" if now < @opened_at + @cooldown
      @state = :half_open
    end
    result = yield
    @failures = 0
    @state = :closed
    result
  rescue CircuitOpen
    raise
  rescue StandardError
    @failures += 1
    if @state == :half_open || @failures >= @threshold
      @state = :open
      @opened_at = now
    end
    raise
  end
end

breaker = CircuitBreaker.new(threshold: 2, cooldown: 5)
healthy_from = 8
(0..11).each do |t|
  outcome = breaker.call(t) do
    raise IOError, "down" if t < healthy_from
    "ok"
  end
  puts "t=#{t.to_s.rjust(2)} #{outcome} (#{breaker.state})"
rescue CircuitOpen => e
  puts "t=#{t.to_s.rjust(2)} short-circuited: #{e.message}"
rescue IOError => e
  puts "t=#{t.to_s.rjust(2)} failed: #{e.message} (#{breaker.state})"
end
