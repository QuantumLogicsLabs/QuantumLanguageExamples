# Catalan numbers and what they count.
def catalan(n) = (n + 2..2 * n).reduce(1, :*) / (1..n).reduce(1, :*)

def balanced(n)
  return [""] if n.zero?
  (0...n).flat_map { |i| balanced(i).product(balanced(n - 1 - i)).map { |a, b| "(#{a})#{b}" } }
end

dp = [1]
(1..15).each { |n| dp << (0...n).sum { |i| dp[i] * dp[n - 1 - i] } }
puts dp.inspect
puts (0..15).map { |n| catalan(n) } == dp
puts balanced(3).inspect
puts balanced(4).size
puts "Binary trees with 10 nodes: #{catalan(10)}"
