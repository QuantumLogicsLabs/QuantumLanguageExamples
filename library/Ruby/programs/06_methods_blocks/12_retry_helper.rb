# A retry helper built on blocks, with a fake flaky service.
class FlakyError < StandardError; end

def with_retries(attempts:)
  tries = 0
  begin
    tries += 1
    yield tries
  rescue FlakyError => e
    puts "  attempt #{tries} failed: #{e.message}"
    retry if tries < attempts
    raise
  end
end

failures = { "fetch" => 2, "save" => 5 }
%w[fetch save].each do |job|
  puts "Running #{job}:"
  begin
    result = with_retries(attempts: 3) do |n|
      raise FlakyError, "timeout" if n <= failures[job]
      "#{job} ok on attempt #{n}"
    end
    puts "  #{result}"
  rescue FlakyError
    puts "  gave up on #{job}"
  end
end
