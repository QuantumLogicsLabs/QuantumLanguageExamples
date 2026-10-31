# Driving enumerators manually with next and peek.
e = [10, 20, 30].each
puts e.next
puts e.peek
puts e.next
puts e.next
begin
  e.next
rescue StopIteration
  puts "done"
end
e.rewind
puts e.next

letters = %w[a b c].each
numbers = [1, 2, 3, 4].each
pairs = []
loop { pairs << "#{letters.next}#{numbers.next}" }
puts pairs.inspect

def merge_sorted(a, b)
  ea, eb = a.each, b.each
  out = []
  loop do
    out << (ea.peek <= eb.peek ? ea.next : eb.next)
  end
  out + (begin
    rest = []
    loop { rest << ea.next }
    rest
  end) + (begin
    rest = []
    loop { rest << eb.next }
    rest
  end)
end
puts merge_sorted([1, 4, 9], [2, 3, 10, 11]).inspect
