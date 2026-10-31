# Fewest coins for an amount, and which coins.
def min_coins(coins, amount)
  best = Array.new(amount + 1, Float::INFINITY)
  last = Array.new(amount + 1)
  best[0] = 0
  (1..amount).each do |a|
    coins.each do |c|
      next if c > a || best[a - c] + 1 >= best[a]
      best[a] = best[a - c] + 1
      last[a] = c
    end
  end
  return nil if best[amount].infinite?
  used = []
  a = amount
  while a.positive?
    used << last[a]
    a -= last[a]
  end
  used.sort.reverse
end

[[[1, 5, 10, 25], 63], [[1, 3, 4], 6], [[2], 7], [[9, 6, 5, 1], 11], [[1, 7, 10], 14]].each do |coins, amount|
  used = min_coins(coins, amount)
  puts "#{amount} with #{coins.inspect}: #{used ? "#{used.size} coins #{used.inspect}" : 'impossible'}"
end
