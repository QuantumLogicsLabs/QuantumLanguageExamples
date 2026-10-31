# The 24 game: combine four numbers with + - * / to make 24.
def solve24(nums, target = Rational(24))
  return nums.first[1] if nums.size == 1 && nums.first[0] == target
  return nil if nums.size == 1
  nums.combination(2).each do |a, b|
    rest = nums.dup
    rest.delete_at(rest.index(a))
    rest.delete_at(rest.index(b))
    ops = [[a[0] + b[0], "(#{a[1]}+#{b[1]})"], [a[0] - b[0], "(#{a[1]}-#{b[1]})"], [b[0] - a[0], "(#{b[1]}-#{a[1]})"],
           [a[0] * b[0], "#{a[1]}*#{b[1]}"]]
    ops << [a[0] / b[0], "#{a[1]}/#{b[1]}"] unless b[0].zero?
    ops << [b[0] / a[0], "#{b[1]}/#{a[1]}"] unless a[0].zero?
    ops.each do |value, expr|
      found = solve24(rest + [[value, expr]], target)
      return found if found
    end
  end
  nil
end

[[4, 7, 8, 8], [1, 2, 3, 4], [3, 3, 8, 8], [1, 1, 1, 1], [6, 6, 6, 6], [1, 5, 5, 5]].each do |hand|
  expr = solve24(hand.map { |n| [Rational(n), n.to_s] })
  puts "#{hand.inspect}: #{expr || 'no solution'}"
end
