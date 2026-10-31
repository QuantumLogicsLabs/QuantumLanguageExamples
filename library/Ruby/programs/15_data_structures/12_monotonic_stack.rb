# Next greater elements and stock spans with a monotonic stack.
def next_greater(a)
  result = Array.new(a.size, -1)
  stack = []
  a.each_with_index do |x, i|
    result[stack.pop] = x while !stack.empty? && a[stack.last] < x
    stack << i
  end
  result
end

def stock_span(prices)
  stack = []
  prices.each_with_index.map do |p, i|
    stack.pop while !stack.empty? && prices[stack.last] <= p
    span = stack.empty? ? i + 1 : i - stack.last
    stack << i
    span
  end
end

def largest_rectangle(heights)
  stack = []
  best = 0
  (heights + [0]).each_with_index do |h, i|
    while !stack.empty? && heights[stack.last] > h
      height = heights[stack.pop]
      width = stack.empty? ? i : i - stack.last - 1
      best = [best, height * width].max
    end
    stack << i
  end
  best
end

puts next_greater([4, 5, 2, 25, 7, 8]).inspect
puts stock_span([100, 80, 60, 70, 60, 75, 85]).inspect
puts largest_rectangle([2, 1, 5, 6, 2, 3])
puts largest_rectangle([6, 2, 5, 4, 5, 1, 6])
