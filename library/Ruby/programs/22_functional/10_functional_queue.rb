# A persistent queue built from two immutable lists.
FQueue = Data.define(:front, :back) do
  def self.empty = new(front: [].freeze, back: [].freeze)
  def push(x) = with(back: ([x] + back).freeze)
  def empty? = front.empty? && back.empty?

  def pop
    return [nil, self] if empty?
    return FQueue.new(front: back.reverse.freeze, back: [].freeze).pop if front.empty?
    [front.first, with(front: front.drop(1).freeze)]
  end

  def to_a = front + back.reverse
end

q0 = FQueue.empty
q1 = q0.push(1).push(2).push(3)
x, q2 = q1.pop
q3 = q2.push(4)
puts "q1 #{q1.to_a.inspect}, popped #{x}, q2 #{q2.to_a.inspect}, q3 #{q3.to_a.inspect}"
puts "q0 still empty: #{q0.empty?}, q1 unchanged: #{q1.to_a.inspect}"
q = q3
out = []
until q.empty?
  v, q = q.pop
  out << v
end
puts out.inspect
