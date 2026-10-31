# Trampolines: deep recursion without growing the stack.
Bounce = Struct.new(:thunk)

def trampoline(result)
  result = result.thunk.call while result.is_a?(Bounce)
  result
end

def sum_to(n, acc = 0) = n.zero? ? acc : Bounce.new(-> { sum_to(n - 1, acc + n) })
def even_t(n) = n.zero? ? true : Bounce.new(-> { odd_t(n - 1) })
def odd_t(n) = n.zero? ? false : Bounce.new(-> { even_t(n - 1) })

def count_down_plain(n) = n.zero? ? 0 : count_down_plain(n - 1)

puts trampoline(sum_to(100_000))
puts trampoline(even_t(100_001))
puts trampoline(odd_t(100_001))
begin
  count_down_plain(1_000_000)
  puts "plain recursion survived"
rescue SystemStackError
  puts "plain recursion overflowed the stack"
end
