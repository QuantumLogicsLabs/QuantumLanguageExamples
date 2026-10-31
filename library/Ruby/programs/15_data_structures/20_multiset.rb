# A multiset (bag) with counts.
class Bag
  include Enumerable

  def initialize(items = []) = (@counts = Hash.new(0); items.each { |i| add(i) })
  def add(item, n = 1) = (@counts[item] += n; self)

  def remove(item, n = 1)
    return self unless @counts.key?(item)
    @counts[item] -= n
    @counts.delete(item) if @counts[item] <= 0
    self
  end

  def count_of(item) = @counts.fetch(item, 0)
  def size = @counts.values.sum
  def each(&block) = @counts.each { |item, n| n.times { block.call(item) } }
  def +(other) = Bag.new(to_a + other.to_a)
  def &(other) = Bag.new(@counts.flat_map { |i, n| [i] * [n, other.count_of(i)].min })
  def most_common(k) = @counts.sort_by { |i, n| [-n, i] }.first(k)
  def to_s = "{" + @counts.sort.map { |i, n| "#{i}:#{n}" }.join(", ") + "}"
end

a = Bag.new(%w[apple apple pear fig fig fig])
b = Bag.new(%w[fig pear pear kiwi])
puts a, b
puts a + b
puts a & b
puts a.size, a.count_of("fig")
a.remove("fig", 2).remove("apple").remove("plum")
puts a
puts (a + b).most_common(2).inspect
puts a.sort.inspect
