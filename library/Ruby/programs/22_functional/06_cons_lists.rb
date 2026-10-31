# An immutable linked list made of cons cells.
Cons = Data.define(:head, :tail)
EMPTY = nil

def list(*xs) = xs.reverse.reduce(EMPTY) { |acc, x| Cons.new(x, acc) }
def to_array(l) = l.nil? ? [] : [l.head] + to_array(l.tail)
def length(l) = l.nil? ? 0 : 1 + length(l.tail)
def map_list(l, &f) = l.nil? ? nil : Cons.new(f.(l.head), map_list(l.tail, &f))
def filter_list(l, &p) = l.nil? ? nil : (p.(l.head) ? Cons.new(l.head, filter_list(l.tail, &p)) : filter_list(l.tail, &p))
def fold(l, acc, &f) = l.nil? ? acc : fold(l.tail, f.(acc, l.head), &f)
def append(a, b) = a.nil? ? b : Cons.new(a.head, append(a.tail, b))
def reverse(l) = fold(l, nil) { |acc, x| Cons.new(x, acc) }

xs = list(1, 2, 3, 4, 5)
ys = Cons.new(0, xs)
puts to_array(xs).inspect, to_array(ys).inspect
puts ys.tail.equal?(xs)
puts length(xs)
puts to_array(map_list(xs) { |x| x * x }).inspect
puts to_array(filter_list(xs, &:odd?)).inspect
puts fold(xs, 0) { |a, x| a + x }
puts to_array(append(xs, list(6, 7))).inspect
puts to_array(reverse(xs)).inspect
puts xs == list(1, 2, 3, 4, 5)
