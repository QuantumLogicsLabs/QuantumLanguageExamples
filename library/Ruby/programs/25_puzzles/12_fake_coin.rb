# Finding a lighter fake coin among 12 with a balance scale.
def weigh(coins, left, right)
  l = left.sum { |i| coins[i] }
  r = right.sum { |i| coins[i] }
  l <=> r
end

def find_fake(coins, candidates, log)
  return candidates.first if candidates.size == 1
  third = (candidates.size / 3.0).ceil
  a = candidates[0, third]
  b = candidates[third, third]
  rest = candidates[(2 * third)..] || []
  result = weigh(coins, a, b)
  log << "weigh #{a.inspect} vs #{b.inspect}: #{{ -1 => 'left lighter', 1 => 'right lighter', 0 => 'balanced' }[result]}"
  case result
  when -1 then find_fake(coins, a, log)
  when 1 then find_fake(coins, b, log)
  else find_fake(coins, rest, log)
  end
end

[0, 5, 11, 7].each do |fake|
  coins = Array.new(12, 10)
  coins[fake] = 9
  log = []
  found = find_fake(coins, (0...12).to_a, log)
  puts "fake coin #{fake}: found #{found} in #{log.size} weighings"
  log.each { |l| puts "  #{l}" }
end
