# Folding over an expression tree to evaluate, print and simplify.
Num = Data.define(:value)
Var = Data.define(:name)
Add = Data.define(:left, :right)
Mul = Data.define(:left, :right)

def fold(e, num:, var:, add:, mul:)
  rec = ->(x) { fold(x, num: num, var: var, add: add, mul: mul) }
  case e
  in Num(value:) then num.(value)
  in Var(name:) then var.(name)
  in Add(left:, right:) then add.(rec.(left), rec.(right))
  in Mul(left:, right:) then mul.(rec.(left), rec.(right))
  end
end

expr = Add.new(Mul.new(Num.new(3), Var.new("x")), Add.new(Var.new("y"), Mul.new(Num.new(1), Num.new(4))))
env = { "x" => 5, "y" => 2 }

puts fold(expr, num: ->(v) { v }, var: ->(n) { env.fetch(n) }, add: ->(a, b) { a + b }, mul: ->(a, b) { a * b })
puts fold(expr, num: :to_s.to_proc, var: ->(n) { n }, add: ->(a, b) { "(#{a} + #{b})" }, mul: ->(a, b) { "#{a}*#{b}" })
puts fold(expr, num: ->(_) { 1 }, var: ->(_) { 1 }, add: ->(a, b) { a + b + 1 }, mul: ->(a, b) { a + b + 1 })
vars = fold(expr, num: ->(_) { [] }, var: ->(n) { [n] }, add: :+.to_proc, mul: :+.to_proc)
puts vars.inspect
simplify = fold(expr, num: ->(v) { Num.new(v) }, var: ->(n) { Var.new(n) },
                      add: ->(a, b) { a.is_a?(Num) && b.is_a?(Num) ? Num.new(a.value + b.value) : Add.new(a, b) },
                      mul: ->(a, b) { a == Num.new(1) ? b : a.is_a?(Num) && b.is_a?(Num) ? Num.new(a.value * b.value) : Mul.new(a, b) })
puts simplify.inspect
