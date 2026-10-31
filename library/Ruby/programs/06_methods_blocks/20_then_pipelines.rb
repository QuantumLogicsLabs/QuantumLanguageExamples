# Chaining transformations with then and tap.
result = 5
  .then { |x| x * 3 }
  .then { |x| x + 1 }
  .then { |x| "value: #{x}" }
puts result

report = [3, 1, 4, 1, 5, 9, 2, 6]
  .tap { |a| puts "input: #{a.inspect}" }
  .sort
  .tap { |a| puts "sorted: #{a.inspect}" }
  .uniq
  .then { |a| { count: a.size, median: a[a.size / 2], total: a.sum } }
puts report.inspect

config = {}.tap do |c|
  c[:host] = "localhost"
  c[:port] = 8080
end
puts config.inspect

slug = "  Hello World, From Ruby!  "
  .strip
  .downcase
  .gsub(/[^a-z0-9\s]/, "")
  .split
  .join("-")
puts slug
