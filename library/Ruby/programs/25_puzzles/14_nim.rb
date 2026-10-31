# Nim and Sprague-Grundy values for a subtraction game.
def nim_move(heaps)
  x = heaps.reduce(:^)
  return nil if x.zero?
  heaps.each_with_index do |h, i|
    target = h ^ x
    return [i, h - target] if target < h
  end
end

[[3, 4, 5], [1, 2, 3], [7, 7], [10, 6, 3, 1]].each do |heaps|
  move = nim_move(heaps)
  puts "#{heaps.inspect}: nim-sum #{heaps.reduce(:^)}, #{move ? "take #{move[1]} from heap #{move[0]}" : 'losing position'}"
end

moves = [1, 3, 4]
grundy = []
(0..20).each { |n| grundy << (0..).find { |g| !moves.select { |m| m <= n }.map { |m| grundy[n - m] }.include?(g) } }
puts "subtraction game {1,3,4} grundy: #{grundy.inspect}"
puts "losing positions: #{grundy.each_index.select { |n| grundy[n].zero? }.inspect}"

heaps = [5, 8, 2]
turn = 0
until heaps.all?(&:zero?)
  i, take = nim_move(heaps) || [heaps.index(heaps.max), 1]
  heaps[i] -= take
  puts "player #{turn % 2 + 1} takes #{take} from heap #{i}: #{heaps.inspect}"
  turn += 1
end
puts "player #{(turn - 1) % 2 + 1} takes the last object and wins"
