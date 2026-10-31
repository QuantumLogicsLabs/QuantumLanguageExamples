# Partial application and argument flipping.
def partial(f, *bound) = ->(*rest) { f.(*bound, *rest) }
def flip(f) = ->(a, b) { f.(b, a) }

power = ->(base, exp) { base**exp }
divide = ->(a, b) { a.fdiv(b) }
format_money = ->(currency, amount) { format("%s %.2f", currency, amount) }

square = partial(flip(power), 2)
two_to = partial(power, 2)
half = partial(flip(divide), 2)
usd = partial(format_money, "USD")
eur = format_money.curry["EUR"]

puts (1..6).map(&square).inspect
puts (1..6).map(&two_to).inspect
puts [10, 7, 1].map(&half).inspect
puts [3.5, 1200].map(&usd).inspect
puts eur.(9.99)
add3 = ->(a, b, c) { a + b + c }
puts partial(add3, 1).(2, 3), partial(add3, 1, 2).(3), partial(add3).(1, 2, 3)
