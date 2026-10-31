# Mutually recursive functions.
def even?(n) = n.zero? ? true : odd?(n - 1)
def odd?(n) = n.zero? ? false : even?(n - 1)

# Hofstadter female and male sequences
def f(n) = n.zero? ? 1 : n - m(f(n - 1))
def m(n) = n.zero? ? 0 : n - f(m(n - 1))

puts (0..8).map { |n| "#{n}:#{even?(n) ? 'even' : 'odd'}" }.join(" ")
puts "F: #{(0..15).map { |n| f(n) }.inspect}"
puts "M: #{(0..15).map { |n| m(n) }.inspect}"

def expr(tokens) = term(tokens).then { |v| tokens.first == "+" ? (tokens.shift; v + expr(tokens)) : v }
def term(tokens) = factor(tokens).then { |v| tokens.first == "*" ? (tokens.shift; v * term(tokens)) : v }
def factor(tokens)
  t = tokens.shift
  if t == "("
    v = expr(tokens)
    tokens.shift
    v
  else
    t.to_i
  end
end

["2 + 3 * 4", "( 2 + 3 ) * 4", "2 * ( 3 + 4 ) * 5"].each { |s| puts "#{s} = #{expr(s.split)}" }
