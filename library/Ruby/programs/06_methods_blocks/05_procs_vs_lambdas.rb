# Differences between procs and lambdas.
square = ->(x) { x * x }
add = lambda { |a, b| a + b }
shout = proc { |s| s.to_s.upcase }

puts square.call(4)
puts square.(5)
puts square[6]
puts add.call(2, 3)
puts shout.call("quiet")
puts shout.call
puts square.lambda?
puts shout.lambda?
puts add.arity
puts shout.arity
puts proc { |x, y| }.arity

begin
  add.call(1)
rescue ArgumentError => e
  puts "lambda is strict: #{e.message}"
end
puts proc { |a, b| "a=#{a.inspect} b=#{b.inspect}" }.call(1)

def run_proc
  p = proc { return "returned from method" }
  p.call
  "never reached"
end

def run_lambda
  l = -> { return "returned from lambda" }
  l.call
  "method continued"
end

puts run_proc
puts run_lambda
