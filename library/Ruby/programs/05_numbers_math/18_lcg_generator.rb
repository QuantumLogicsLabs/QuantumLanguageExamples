# A deterministic linear congruential generator and dice statistics.
class LCG
  def initialize(seed)
    @state = seed
  end

  def next_int
    @state = (1_103_515_245 * @state + 12_345) % 2**31
  end

  def rand_below(n) = next_int % n
end

gen = LCG.new(2024)
puts 5.times.map { gen.next_int }.inspect

dice = LCG.new(7)
rolls = Array.new(6000) { dice.rand_below(6) + 1 }
counts = rolls.tally.sort.to_h
counts.each { |face, n| puts "#{face}: #{n.to_s.rjust(4)} #{'#' * (n / 50)}" }
puts "Mean roll: #{(rolls.sum / rolls.size.to_f).round(3)}"

shuffle = LCG.new(1)
deck = (1..10).to_a
(deck.size - 1).downto(1) do |i|
  j = shuffle.rand_below(i + 1)
  deck[i], deck[j] = deck[j], deck[i]
end
puts "Shuffled: #{deck.inspect}"
