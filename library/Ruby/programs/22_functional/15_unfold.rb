# Generating sequences by unfolding from a seed.
def unfold(seed)
  out = []
  loop do
    value, seed = yield(seed)
    break if value.nil?
    out << value
  end
  out
end

puts unfold(1) { |n| n > 100 ? nil : [n, n * 2] }.inspect
puts unfold(1234) { |n| n.zero? ? nil : [n % 10, n / 10] }.reverse.inspect
puts unfold([0, 1]) { |a, b| a > 200 ? nil : [a, [b, a + b]] }.inspect
puts unfold(27) { |n| n == 1 ? nil : [n, n.even? ? n / 2 : 3 * n + 1] }.size
puts unfold(255) { |n| n.zero? ? nil : [n % 2, n / 2] }.reverse.join
puts Enumerator.produce([1, 1]) { |a, b| [b, a + b] }.take(10).map(&:first).inspect
puts Enumerator.produce("ruby", &:succ).take(4).inspect
