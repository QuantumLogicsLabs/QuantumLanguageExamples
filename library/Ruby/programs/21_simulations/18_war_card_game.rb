# The card game War with a deterministically shuffled deck.
def shuffled_deck(seed)
  deck = (2..14).to_a * 4
  state = seed
  (deck.size - 1).downto(1) do |i|
    state = (state * 1_103_515_245 + 12_345) % 2**31
    j = state % (i + 1)
    deck[i], deck[j] = deck[j], deck[i]
  end
  deck
end

deck = shuffled_deck(42)
a, b = deck.each_slice(26).to_a
rounds = wars = 0
while !a.empty? && !b.empty? && rounds < 2000
  rounds += 1
  pot = [a.shift, b.shift]
  while pot[-2] == pot[-1]
    wars += 1
    break if a.size < 2 || b.size < 2
    pot.concat([a.shift, b.shift, a.shift, b.shift])
  end
  winner = pot[-2] > pot[-1] ? a : b
  winner.concat(pot.sort.reverse)
  puts "after round #{rounds}: #{a.size} vs #{b.size}" if (rounds % 100).zero?
end
puts "game over after #{rounds} rounds with #{wars} wars: #{a.size} vs #{b.size}"
