# Multiplicative and additive persistence of numbers.
def additive(n)
  steps = 0
  while n > 9
    n = n.digits.sum
    steps += 1
  end
  [steps, n]
end

def multiplicative(n)
  steps = 0
  while n > 9
    n = n.digits.reduce(:*)
    steps += 1
  end
  [steps, n]
end

[39, 999, 277777788888899, 123456789, 10].each do |n|
  a = additive(n)
  m = multiplicative(n)
  puts "#{n}: additive #{a[0]} steps -> #{a[1]}, multiplicative #{m[0]} steps -> #{m[1]}"
end
best = (1..10_000).max_by { |n| multiplicative(n)[0] }
puts "Smallest number below 10000 with the most multiplicative steps: #{best} (#{multiplicative(best)[0]})"
