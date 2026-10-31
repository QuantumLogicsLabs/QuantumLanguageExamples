# while and until loops: Collatz sequences and a countdown.
def collatz_steps(n)
  steps = 0
  while n != 1
    n = n.even? ? n / 2 : 3 * n + 1
    steps += 1
  end
  steps
end

(1..10).each { |n| puts "collatz(#{n}) takes #{collatz_steps(n)} steps" }

count = 5
until count.zero?
  print count, " "
  count -= 1
end
puts "liftoff!"

n = 27
path = [n]
path << (n = n.even? ? n / 2 : 3 * n + 1) while n != 1
puts "27 reaches 1 after #{path.size - 1} steps, peaking at #{path.max}"
