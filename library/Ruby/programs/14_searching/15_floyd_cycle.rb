# Floyd's tortoise and hare: duplicates and cycle detection.
def find_duplicate(nums)
  slow = fast = nums[0]
  loop do
    slow = nums[slow]
    fast = nums[nums[fast]]
    break if slow == fast
  end
  slow = nums[0]
  until slow == fast
    slow = nums[slow]
    fast = nums[fast]
  end
  slow
end

def cycle_info(f, x0)
  tortoise, hare = f.(x0), f.(f.(x0))
  tortoise, hare = f.(tortoise), f.(f.(hare)) until tortoise == hare
  mu = 0
  tortoise = x0
  until tortoise == hare
    tortoise, hare = f.(tortoise), f.(hare)
    mu += 1
  end
  lam = 1
  hare = f.(tortoise)
  until tortoise == hare
    hare = f.(hare)
    lam += 1
  end
  [mu, lam]
end

puts find_duplicate([1, 3, 4, 2, 2])
puts find_duplicate([3, 1, 3, 4, 2])
step = ->(x) { (x * x + 1) % 255 }
mu, lam = cycle_info(step, 3)
puts "x -> x^2+1 mod 255 from 3: tail #{mu}, cycle length #{lam}"
puts "sequence: #{(1..12).reduce([3]) { |s, _| s << step.(s.last) }.inspect}"
