# What exception objects carry.
begin
  raise ArgumentError, "bad argument"
rescue => e
  puts e.class
  puts e.message
  puts e.is_a?(StandardError)
  puts e.full_message(highlight: false).lines.first.include?("bad argument")
end

err = RuntimeError.new("built by hand")
puts err.message
puts err.inspect
puts err.backtrace.inspect

class DetailedError < StandardError
  attr_reader :code
  def initialize(code) = (@code = code; super("failed with code #{code}"))
end

begin
  raise DetailedError.new(503)
rescue DetailedError => e
  puts "#{e.message} [#{e.code}]"
end

e2 = DetailedError.new(404).exception("custom text")
puts e2.message
puts e2.code
puts (StandardError.new == StandardError.new)
