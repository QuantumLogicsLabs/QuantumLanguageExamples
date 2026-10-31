# A bit set stored in an Integer.
class BitSet
  include Enumerable

  def initialize(bits = 0) = @bits = bits
  def add(i) = BitSet.new(@bits | (1 << i))
  def remove(i) = BitSet.new(@bits & ~(1 << i))
  def include?(i) = @bits[i] == 1
  def |(o) = BitSet.new(bits | o.bits)
  def &(o) = BitSet.new(bits & o.bits)
  def size = @bits.to_s(2).count("1")
  def each
    i = 0
    b = @bits
    while b.positive?
      yield i if b.odd?
      b >>= 1
      i += 1
    end
  end
  def to_s = "{#{to_a.join(', ')}}"

  protected

  attr_reader :bits
end

a = [1, 3, 5, 64].reduce(BitSet.new) { |s, i| s.add(i) }
b = [3, 4, 5].reduce(BitSet.new) { |s, i| s.add(i) }
puts a, b, a | b, a & b
puts a.include?(64), a.include?(2)
puts a.remove(3)
puts (a | b).size
puts (a | b).select(&:even?).inspect
