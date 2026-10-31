# Retrying with exponential backoff (simulated clock, no sleeping).
class TransientError < StandardError; end

class FlakyService
  def initialize(fail_times) = (@fail_times, @calls = fail_times, 0)
  attr_reader :calls

  def fetch
    @calls += 1
    raise TransientError, "unavailable (call #{@calls})" if @calls <= @fail_times
    "payload after #{@calls} calls"
  end
end

def with_backoff(max_attempts:, base: 100)
  attempt = 0
  waited = 0
  begin
    attempt += 1
    yield
  rescue TransientError => e
    raise if attempt >= max_attempts
    delay = base * 2**(attempt - 1)
    waited += delay
    puts "  #{e.message}; waiting #{delay}ms"
    retry
  ensure
    puts "  total simulated wait #{waited}ms" if $!.nil? || attempt >= max_attempts
  end
end

[2, 5].each do |failures|
  service = FlakyService.new(failures)
  puts "Service failing #{failures} times:"
  begin
    puts "  " + with_backoff(max_attempts: 4) { service.fetch }
  rescue TransientError => e
    puts "  giving up: #{e.message}"
  end
end
