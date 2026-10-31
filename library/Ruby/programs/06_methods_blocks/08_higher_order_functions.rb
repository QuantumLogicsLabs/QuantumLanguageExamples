# Functions that build and combine functions.
def multiplier(n) = ->(x) { x * n }
def adder(n) = ->(x) { x + n }

triple = multiplier(3)
add_ten = adder(10)
puts triple.(7)
puts (triple >> add_ten).(2)
puts (triple << add_ten).(2)

def compose_all(*fns)
  fns.reduce { |f, g| f >> g }
end

process = compose_all(adder(1), multiplier(2), ->(x) { x - 3 }, :to_s.to_proc)
puts process.(5).inspect

def apply_n(f, n, x)
  n.times.reduce(x) { |acc, _| f.(acc) }
end
puts apply_n(multiplier(2), 10, 1)

transforms = { "double" => multiplier(2), "square" => ->(x) { x * x }, "negate" => :-@.to_proc }
transforms.each { |name, f| puts "#{name}(6) = #{f.(6)}" }
