# Maximum loot without robbing adjacent houses (line and circle).
def rob_line(houses)
  take, skip = 0, 0
  houses.each { |h| take, skip = skip + h, [take, skip].max }
  [take, skip].max
end

def rob_circle(houses)
  return houses.first || 0 if houses.size <= 1
  [rob_line(houses[1..]), rob_line(houses[0...-1])].max
end

def rob_choice(houses)
  dp = [0, 0]
  houses.each { |h| dp << [dp[-1], dp[-2] + h].max }
  chosen = []
  i = houses.size
  while i.positive?
    if dp[i + 1] == dp[i]
      i -= 1
    else
      chosen.unshift(i - 1)
      i -= 2
    end
  end
  chosen
end

[[2, 7, 9, 3, 1], [1, 2, 3, 1], [2, 3, 2], [6, 7, 1, 30, 8, 2, 4], [5]].each do |h|
  puts "#{h.inspect}: line #{rob_line(h)} via houses #{rob_choice(h).inspect}, circle #{rob_circle(h)}"
end
