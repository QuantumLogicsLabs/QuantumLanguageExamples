# Finding peaks in arrays and grids.
def find_peak(a)
  lo, hi = 0, a.size - 1
  while lo < hi
    mid = (lo + hi) / 2
    a[mid] < a[mid + 1] ? lo = mid + 1 : hi = mid
  end
  lo
end

def all_peaks(a) = a.each_index.select { |i| (i.zero? || a[i] > a[i - 1]) && (i == a.size - 1 || a[i] > a[i + 1]) }

def grid_peak(g)
  r, c = 0, 0
  loop do
    best = [[r, c]] + [[r - 1, c], [r + 1, c], [r, c - 1], [r, c + 1]].select { |y, x| y.between?(0, g.size - 1) && x.between?(0, g[0].size - 1) }
    nr, nc = best.max_by { |y, x| g[y][x] }
    return [r, c] if [nr, nc] == [r, c]
    r, c = nr, nc
  end
end

series = [1, 3, 20, 4, 1, 0, 7, 9, 2]
puts "A peak: index #{find_peak(series)} (#{series[find_peak(series)]})"
puts "All peaks: #{all_peaks(series).inspect}"
grid = [[1, 2, 3, 4], [2, 9, 4, 5], [3, 4, 8, 13], [1, 2, 11, 6]]
puts "Grid peak from (0,0): #{grid_peak(grid).inspect}"
