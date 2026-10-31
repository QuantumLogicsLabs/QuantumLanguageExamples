# Numbers and booleans encoded as functions.
ZERO = ->(_f) { ->(x) { x } }
SUCC = ->(n) { ->(f) { ->(x) { f.(n.(f).(x)) } } }
ADD = ->(m) { ->(n) { ->(f) { ->(x) { m.(f).(n.(f).(x)) } } } }
MUL = ->(m) { ->(n) { ->(f) { m.(n.(f)) } } }
POW = ->(b) { ->(e) { e.(b) } }
TO_INT = ->(n) { n.(->(x) { x + 1 }).(0) }

TRUE = ->(a) { ->(_b) { a } }
FALSE = ->(_a) { ->(b) { b } }
IS_ZERO = ->(n) { n.(->(_) { FALSE }).(TRUE) }
TO_BOOL = ->(b) { b.(true).(false) }

one = SUCC.(ZERO)
two = SUCC.(one)
three = ADD.(one).(two)
puts [ZERO, one, two, three].map(&TO_INT).inspect
puts TO_INT.(MUL.(three).(three))
puts TO_INT.(POW.(two).(SUCC.(three)))
puts TO_BOOL.(IS_ZERO.(ZERO)), TO_BOOL.(IS_ZERO.(two))
from_int = ->(k) { k.times.reduce(ZERO) { |n, _| SUCC.(n) } }
puts TO_INT.(ADD.(from_int.(17)).(from_int.(25)))
