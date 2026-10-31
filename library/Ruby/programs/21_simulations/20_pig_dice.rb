# The dice game Pig with fixed dice rolls and two strategies.
ROLLS = [3, 5, 1, 6, 6, 2, 4, 1, 5, 5, 3, 6, 2, 2, 1, 4, 6, 6, 5, 3, 1, 2, 4, 6, 5, 5, 6, 3, 4, 2, 1, 6, 6, 6, 4]
        .cycle

strategies = {
  "cautious" => ->(turn_total, _score) { turn_total >= 10 },
  "bold" => ->(turn_total, score) { turn_total >= 20 || score + turn_total >= 50 }
}
scores = strategies.keys.to_h { |k| [k, 0] }
turn = 0
winner = nil

until winner
  name = strategies.keys[turn % 2]
  total = 0
  rolls = []
  loop do
    roll = ROLLS.next
    rolls << roll
    if roll == 1
      total = 0
      break
    end
    total += roll
    break if strategies[name].(total, scores[name])
  end
  scores[name] += total
  puts "turn #{turn + 1}: #{name.ljust(8)} rolled #{rolls.join(',').ljust(14)} +#{total.to_s.ljust(2)} => #{scores[name]}"
  winner = name if scores[name] >= 50
  turn += 1
end
puts "#{winner} wins #{scores.inspect}"
