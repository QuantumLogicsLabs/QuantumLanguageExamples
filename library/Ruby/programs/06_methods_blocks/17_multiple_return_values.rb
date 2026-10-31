# Returning and destructuring several values.
def min_max_avg(values)
  [values.min, values.max, values.sum.fdiv(values.size)]
end

def split_name(full)
  *given, family = full.split
  [given.join(" "), family]
end

def divide(a, b)
  return [nil, "division by zero"] if b.zero?
  [a / b, nil]
end

low, high, avg = min_max_avg([4, 8, 15, 16, 23, 42])
puts "low=#{low} high=#{high} avg=#{avg}"

first, last = split_name("Mary Ann Evans")
puts "given='#{first}' family='#{last}'"

[[10, 2], [5, 0]].each do |a, b|
  result, error = divide(a, b)
  puts error ? "#{a}/#{b}: #{error}" : "#{a}/#{b} = #{result}"
end

q, r = 47.divmod(5)
puts "47 = 5 * #{q} + #{r}"
