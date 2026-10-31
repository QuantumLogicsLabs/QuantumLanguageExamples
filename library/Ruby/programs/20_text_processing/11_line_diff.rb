# A line-based diff using the longest common subsequence.
def diff(a, b)
  dp = Array.new(a.size + 1) { Array.new(b.size + 1, 0) }
  (a.size - 1).downto(0) do |i|
    (b.size - 1).downto(0) do |j|
      dp[i][j] = a[i] == b[j] ? dp[i + 1][j + 1] + 1 : [dp[i + 1][j], dp[i][j + 1]].max
    end
  end
  out = []
  i = j = 0
  while i < a.size || j < b.size
    if i < a.size && j < b.size && a[i] == b[j]
      out << "  #{a[i]}"
      i += 1
      j += 1
    elsif j < b.size && (i == a.size || dp[i][j + 1] >= dp[i + 1][j])
      out << "+ #{b[j]}"
      j += 1
    else
      out << "- #{a[i]}"
      i += 1
    end
  end
  out
end

old = ["def greet(name)", "  puts \"Hello \" + name", "end", "", "greet(\"world\")"]
new = ["def greet(name, punct = \"!\")", "  puts \"Hello, \#{name}\#{punct}\"", "end", "", "greet(\"world\")", "greet(\"Ruby\", \"?\")"]
puts diff(old, new)
changes = diff(old, new).group_by { |l| l[0] }.transform_values(&:size)
puts changes.inspect
