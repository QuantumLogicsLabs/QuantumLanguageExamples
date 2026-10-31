# Closures capture their surrounding variables.
def make_counter(start = 0, step = 1)
  count = start
  increment = -> { count += step }
  current = -> { count }
  reset = -> { count = start }
  [increment, current, reset]
end

inc, cur, reset = make_counter(10, 5)
3.times { inc.call }
puts cur.call
reset.call
puts cur.call

counters = (1..3).map { |i| -> { i * 100 } }
puts counters.map(&:call).inspect

total = 0
[1, 2, 3, 4].each { |n| total += n }
puts total

def make_accumulator
  sum = 0
  ->(x) { sum += x }
end
acc = make_accumulator
puts [5, 10, 20].map { |x| acc.(x) }.inspect

x = 1
change_x = -> { x = 99 }
change_x.call
puts x
