# The egg dropping puzzle.
def min_drops(eggs, floors)
  dp = Array.new(eggs + 1) { Array.new(floors + 1, 0) }
  (1..floors).each { |f| dp[1][f] = f }
  (2..eggs).each do |e|
    (1..floors).each do |f|
      dp[e][f] = (1..f).map { |x| 1 + [dp[e - 1][x - 1], dp[e][f - x]].max }.min
    end
  end
  dp[eggs][floors]
end

def floors_coverable(eggs, drops)
  return 0 if eggs.zero? || drops.zero?
  floors_coverable(eggs - 1, drops - 1) + floors_coverable(eggs, drops - 1) + 1
end

[[1, 10], [2, 10], [2, 36], [2, 100], [3, 100], [4, 50]].each do |e, f|
  puts "#{e} eggs, #{f} floors: #{min_drops(e, f)} drops"
end
puts "2 eggs and 14 drops cover #{floors_coverable(2, 14)} floors"
