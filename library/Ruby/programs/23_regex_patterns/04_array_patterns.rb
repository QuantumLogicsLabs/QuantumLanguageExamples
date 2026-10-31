# case/in with array patterns.
def describe(value)
  case value
  in [] then "empty"
  in [x] then "one element: #{x}"
  in [Integer => a, Integer => b] then "two integers summing to #{a + b}"
  in [first, *, last] if first == last then "starts and ends with #{first}"
  in [String => head, *rest] then "#{head} followed by #{rest.size} more"
  in [[x, y], *] then "begins with pair #{x},#{y}"
  in [_, _, *rest] then "#{rest.size + 2} elements"
  end
end

[[], [7], [3, 4], [1, 2, 1], ["a", 2, 3], [[0, 9], 5], [:a, :b, :c, :d]].each do |v|
  puts "#{v.inspect.ljust(20)} #{describe(v)}"
end

point = [3, -4]
case point
in [0, 0] then puts "origin"
in [x, 0] then puts "on x axis at #{x}"
in [x, y] if x.positive? && y.negative? then puts "quadrant IV (#{x}, #{y})"
in [x, y] then puts "somewhere: #{x}, #{y}"
end
