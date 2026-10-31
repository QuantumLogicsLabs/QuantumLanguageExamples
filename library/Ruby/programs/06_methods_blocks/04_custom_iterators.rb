# Re-implementing each, map, select and reduce with yield.
module MyEnumerable
  def my_map
    out = []
    my_each { |x| out << yield(x) }
    out
  end

  def my_select
    out = []
    my_each { |x| out << x if yield(x) }
    out
  end

  def my_reduce(acc)
    my_each { |x| acc = yield(acc, x) }
    acc
  end
end

class NumberList
  include MyEnumerable

  def initialize(*items)
    @items = items
  end

  def my_each
    i = 0
    while i < @items.size
      yield @items[i]
      i += 1
    end
    self
  end
end

list = NumberList.new(3, 8, 1, 9, 4)
list.my_each { |x| print x, " " }
puts
puts list.my_map { |x| x * x }.inspect
puts list.my_select(&:even?).inspect
puts list.my_reduce(0) { |a, b| a + b }
puts list.my_reduce(1) { |a, b| a * b }
