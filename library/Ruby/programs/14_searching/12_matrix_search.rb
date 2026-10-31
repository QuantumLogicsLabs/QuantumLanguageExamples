# Searching a matrix sorted by rows and columns.
def staircase(m, target)
  r, c = 0, m[0].size - 1
  steps = 0
  while r < m.size && c >= 0
    steps += 1
    v = m[r][c]
    return [[r, c], steps] if v == target
    v > target ? c -= 1 : r += 1
  end
  [nil, steps]
end

def flat_binary(m, target)
  cols = m[0].size
  idx = (0...m.size * cols).bsearch { |i| m[i / cols][i % cols] >= target }
  idx && m[idx / cols][idx % cols] == target ? [idx / cols, idx % cols] : nil
end

m = [[1, 4, 7, 11], [2, 5, 8, 12], [3, 6, 9, 16], [10, 13, 14, 17]]
[5, 14, 1, 17, 15].each do |t|
  pos, steps = staircase(m, t)
  puts "#{t}: #{pos.inspect} in #{steps} steps"
end
fully_sorted = [[1, 3, 5], [7, 9, 11], [13, 15, 17]]
[9, 17, 4].each { |t| puts "flat #{t}: #{flat_binary(fully_sorted, t).inspect}" }
