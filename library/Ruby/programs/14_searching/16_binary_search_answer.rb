# Binary search over the answer: minimum ship capacity.
def days_needed(weights, capacity)
  days = 1
  load = 0
  weights.each do |w|
    if load + w > capacity
      days += 1
      load = 0
    end
    load += w
  end
  days
end

def min_capacity(weights, days)
  lo, hi = weights.max, weights.sum
  while lo < hi
    mid = (lo + hi) / 2
    days_needed(weights, mid) <= days ? hi = mid : lo = mid + 1
  end
  lo
end

parcels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
[1, 3, 5, 10].each { |d| puts "#{d} days: capacity #{min_capacity(parcels, d)}" }
puts "Koko bananas: #{(1..30).find { |k| [3, 6, 7, 11].sum { |p| (p + k - 1) / k } <= 8 }} per hour"
