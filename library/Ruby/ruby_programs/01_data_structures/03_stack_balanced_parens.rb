# Array-backed Stack used to check whether brackets in an expression
# are balanced (classic compiler/parser building block).
class Stack
  def initialize
    @data = []
  end

  def push(x)
    @data.push(x)
  end

  def pop
    @data.pop
  end

  def peek
    @data.last
  end

  def empty?
    @data.empty?
  end

  def size
    @data.size
  end
end

def balanced?(expression)
  stack = Stack.new
  pairs = { ')' => '(', ']' => '[', '}' => '{' }
  expression.each_char do |ch|
    if '([{'.include?(ch)
      stack.push(ch)
    elsif ')]}'.include?(ch)
      return false if stack.empty? || stack.pop != pairs[ch]
    end
  end
  stack.empty?
end

if __FILE__ == $0
  tests = ['(a+b)*[c-d]', '([)]', '{[()()]}', '((()']
  tests.each { |t| puts "#{t.ljust(15)} => balanced? #{balanced?(t)}" }
end
