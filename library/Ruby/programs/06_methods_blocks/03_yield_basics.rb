# Methods that take blocks.
def twice
  yield
  yield
end

twice { puts "Hello from the block" }

def with_label(label)
  result = yield(label.upcase, label.length)
  "#{label} -> #{result}"
end

puts with_label("ruby") { |up, len| "#{up}/#{len}" }

def maybe_block
  if block_given?
    "block says #{yield}"
  else
    "no block given"
  end
end

puts maybe_block
puts maybe_block { 42 }

def repeat(n)
  return to_enum(:repeat, n) unless block_given?
  n.times { |i| yield i }
end

repeat(3) { |i| print i, " " }
puts
puts repeat(4).map { |i| i * 10 }.inspect
