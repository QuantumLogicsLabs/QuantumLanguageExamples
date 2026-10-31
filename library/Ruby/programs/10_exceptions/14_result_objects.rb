# Returning result objects instead of raising.
Ok = Struct.new(:value) do
  def ok? = true
  def map = Ok.new(yield(value))
  def then = yield(value)
  def to_s = "Ok(#{value})"
end

Err = Struct.new(:error) do
  def ok? = false
  def map = self
  def then = self
  def to_s = "Err(#{error})"
end

def parse_int(s) = s.match?(/\A-?\d+\z/) ? Ok.new(s.to_i) : Err.new("not an integer: #{s}")
def positive(n) = n.positive? ? Ok.new(n) : Err.new("not positive: #{n}")
def reciprocal(n) = Ok.new(Rational(1, n))

%w[4 -3 abc 25].each do |input|
  result = parse_int(input).then { |n| positive(n) }.then { |n| reciprocal(n) }.map { |r| r.to_f }
  puts "#{input.ljust(4)} => #{result}"
end
results = %w[1 2 x 4].map { |s| parse_int(s) }
puts "#{results.count(&:ok?)} parsed, #{results.reject(&:ok?).map(&:error).inspect}"
