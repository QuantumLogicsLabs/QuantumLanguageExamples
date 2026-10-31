# Towers of Hanoi, printing moves and counting them.
def hanoi(n, from, to, via, moves)
  return if n.zero?
  hanoi(n - 1, from, via, to, moves)
  moves << [n, from, to]
  hanoi(n - 1, via, to, from, moves)
end

moves = []
hanoi(3, "A", "C", "B", moves)
moves.each_with_index { |(disk, from, to), i| puts "#{(i + 1).to_s.rjust(2)}. move disk #{disk} #{from} -> #{to}" }

(1..10).each do |n|
  m = []
  hanoi(n, "A", "C", "B", m)
  print "#{n}:#{m.size} "
end
puts

pegs = { "A" => [4, 3, 2, 1], "B" => [], "C" => [] }
all = []
hanoi(4, "A", "C", "B", all)
all.each { |_, f, t| pegs[t].push(pegs[f].pop) }
puts pegs.inspect
