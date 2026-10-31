# A double-ended queue built on an array, used for a sliding window maximum.
class Deque
  def initialize = @items = []
  def push_back(x) = @items.push(x)
  def push_front(x) = @items.unshift(x)
  def pop_back = @items.pop
  def pop_front = @items.shift
  def front = @items.first
  def back = @items.last
  def empty? = @items.empty?
  def size = @items.size
  def to_a = @items.dup
end

def window_max(values, k)
  dq = Deque.new
  out = []
  values.each_with_index do |v, i|
    dq.pop_front if !dq.empty? && dq.front <= i - k
    dq.pop_back while !dq.empty? && values[dq.back] <= v
    dq.push_back(i)
    out << values[dq.front] if i >= k - 1
  end
  out
end

d = Deque.new
d.push_back(1); d.push_back(2); d.push_front(0)
puts d.to_a.inspect
puts d.pop_front, d.pop_back, d.size
puts window_max([1, 3, -1, -3, 5, 3, 6, 7], 3).inspect
puts window_max([9, 8, 7, 6, 5], 2).inspect
