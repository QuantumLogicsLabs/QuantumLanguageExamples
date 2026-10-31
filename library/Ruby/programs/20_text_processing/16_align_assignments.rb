# Aligning '=' signs and comments in code.
code = <<~RUBY
  x = 1
  total_count = 42 # running total
  name = "Ruby"
  very_long_variable_name = [1, 2, 3] # list
  y = x + total_count
RUBY

lines = code.lines.map(&:chomp)
parts = lines.map do |l|
  lhs, rest = l.split(" = ", 2)
  expr, comment = rest.split(" # ", 2)
  [lhs, expr, comment]
end
lhs_w = parts.map { |p| p[0].size }.max
expr_w = parts.map { |p| p[1].size }.max
parts.each do |lhs, expr, comment|
  line = "#{lhs.ljust(lhs_w)} = #{expr}"
  line = "#{lhs.ljust(lhs_w)} = #{expr.ljust(expr_w)} # #{comment}" if comment
  puts line
end
