# Sierpinski triangle drawn recursively as text.
def sierpinski(n)
  return ["*"] if n.zero?
  prev = sierpinski(n - 1)
  pad = " " * (2**(n - 1))
  prev.map { |line| pad + line + pad } + prev.map { |line| line + " " + line }
end

sierpinski(4).each { |line| puts line.rstrip }

def koch_length(n, len) = n.zero? ? len : 4 * koch_length(n - 1, len / 3.0)
puts (0..5).map { |n| koch_length(n, 1.0).round(4) }.inspect
