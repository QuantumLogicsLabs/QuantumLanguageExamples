# A stack class used to evaluate postfix expressions.
class Stack
  class EmptyError < StandardError; end

  def initialize = @items = []
  def push(x) = @items.push(x) && self
  def peek = @items.last
  def size = @items.size
  def empty? = @items.empty?

  def pop
    raise EmptyError, "pop from empty stack" if empty?
    @items.pop
  end

  def to_s = "Stack#{@items.inspect}"
end

def eval_postfix(expr)
  stack = Stack.new
  expr.split.each do |tok|
    if tok.match?(/\A-?\d+\z/)
      stack.push(tok.to_i)
    else
      b, a = stack.pop, stack.pop
      stack.push(a.send(tok, b))
    end
  end
  stack.pop
end

s = Stack.new.push(1).push(2).push(3)
puts s
puts s.pop
puts s.peek
puts s.size
["3 4 + 2 *", "5 1 2 + 4 * + 3 -", "2 3 4 * +", "10 2 /"].each { |e| puts "#{e} = #{eval_postfix(e)}" }
begin
  eval_postfix("+")
rescue Stack::EmptyError => e
  puts "Error: #{e.message}"
end
