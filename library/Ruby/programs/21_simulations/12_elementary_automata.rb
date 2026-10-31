# Wolfram's elementary cellular automata.
def run(rule, width, steps)
  cells = Array.new(width, 0)
  cells[width / 2] = 1
  rows = [cells]
  steps.times do
    prev = rows.last
    rows << Array.new(width) do |i|
      pattern = (prev[(i - 1) % width] << 2) | (prev[i] << 1) | prev[(i + 1) % width]
      rule[pattern]
    end
  end
  rows
end

[30, 90, 110].each do |rule|
  puts "Rule #{rule}:"
  run(rule, 31, 15).each { |row| puts row.map { |c| c == 1 ? "#" : " " }.join.rstrip }
end
center = run(30, 101, 50).map { |row| row[50] }
puts "rule 30 centre column: #{center.join}"
