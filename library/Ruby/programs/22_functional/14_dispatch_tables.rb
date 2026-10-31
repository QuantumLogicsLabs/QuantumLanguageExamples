# Replacing conditionals with tables of functions.
OPS = {
  "+" => ->(a, b) { a + b },
  "-" => ->(a, b) { a - b },
  "*" => ->(a, b) { a * b },
  "/" => ->(a, b) { b.zero? ? Float::NAN : a.fdiv(b) },
  "^" => ->(a, b) { a**b },
  "max" => ->(a, b) { [a, b].max }
}.freeze

COMMANDS = {
  "push" => ->(stack, arg) { stack + [arg.to_f] },
  "pop" => ->(stack, _) { stack[0...-1] },
  "dup" => ->(stack, _) { stack + [stack.last] },
  "swap" => ->(stack, _) { stack[0...-2] + stack.last(2).reverse }
}.freeze

def run(program)
  program.split.reduce([]) do |stack, tok|
    cmd, arg = tok.split(":")
    if COMMANDS.key?(cmd) then COMMANDS[cmd].(stack, arg)
    elsif OPS.key?(cmd)
      *rest, a, b = stack
      rest + [OPS[cmd].(a, b)]
    else raise ArgumentError, "unknown #{cmd}"
    end
  end
end

puts run("push:3 push:4 + push:5 *").inspect
puts run("push:2 push:10 ^ dup max push:7 swap -").inspect
puts run("push:1 push:0 /").inspect
puts OPS.map { |sym, f| "6 #{sym} 3 = #{f.(6, 3)}" }
