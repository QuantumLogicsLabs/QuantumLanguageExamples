# product, combination and permutation.
sizes = %w[S M L]
colors = %w[red blue]
puts sizes.product(colors).map { |s, c| "#{s}-#{c}" }.join(" ")

team = %w[ana ben cy dee]
pairs = team.combination(2).to_a
puts "#{pairs.size} pairs: #{pairs.map { |p| p.join('+') }.join(' ')}"

podiums = team.permutation(3).count
puts "Podium orders: #{podiums}"
puts [1, 2, 3].permutation.map(&:join).join(" ")

coins = [1, 2, 5]
ways = (1..3).flat_map { |k| coins.repeated_combination(k).to_a }.select { |c| c.sum == 6 }
puts "Ways to make 6 with up to 3 coins: #{ways.inspect}"
subsets = (0..3).flat_map { |k| [1, 2, 3].combination(k).to_a }
puts "Subsets of [1,2,3]: #{subsets.inspect}"
