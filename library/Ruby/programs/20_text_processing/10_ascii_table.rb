# Rendering rows as an ASCII table.
def table(headers, rows, align = {})
  all = [headers] + rows.map { |r| r.map(&:to_s) }
  widths = headers.each_index.map { |i| all.map { |r| r[i].to_s.size }.max }
  sep = "+" + widths.map { |w| "-" * (w + 2) }.join("+") + "+"
  fmt = lambda do |row|
    "| " + row.each_with_index.map { |cell, i| align[i] == :right ? cell.to_s.rjust(widths[i]) : cell.to_s.ljust(widths[i]) }.join(" | ") + " |"
  end
  [sep, fmt.(headers), sep, *rows.map { |r| fmt.(r) }, sep].join("\n")
end

rows = [
  ["Mercury", 0.39, 88, 0],
  ["Venus", 0.72, 225, 0],
  ["Earth", 1.0, 365, 1],
  ["Mars", 1.52, 687, 2],
  ["Jupiter", 5.2, 4333, 95]
]
puts table(%w[Planet AU Days Moons], rows, { 1 => :right, 2 => :right, 3 => :right })
puts table(%w[Key Value], [["a", 1], ["bb", 22]])
