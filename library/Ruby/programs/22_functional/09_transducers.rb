# Transducers: composable transformations independent of the collection.
mapping = ->(f) { ->(step) { ->(acc, x) { step.(acc, f.(x)) } } }
filtering = ->(p) { ->(step) { ->(acc, x) { p.(x) ? step.(acc, x) : acc } } }
taking = ->(n) do
  ->(step) do
    count = 0
    ->(acc, x) { (count += 1) <= n ? step.(acc, x) : acc }
  end
end

def transduce(xform, step, init, coll)
  f = xform.(step)
  coll.reduce(init) { |acc, x| f.(acc, x) }
end

xform = ->(step) { filtering.(:odd?.to_proc).(mapping.(->(x) { x * x }).(step)) }
conj = ->(acc, x) { acc + [x] }
plus = ->(acc, x) { acc + x }

puts transduce(xform, conj, [], 1..10).inspect
puts transduce(xform, plus, 0, 1..10)
first3 = ->(step) { xform.(taking.(3).(step)) }
puts transduce(first3, conj, [], 1..100).inspect
joiner = ->(acc, x) { acc.empty? ? x.to_s : "#{acc}-#{x}" }
puts transduce(xform, joiner, "", [3, 4, 5])
