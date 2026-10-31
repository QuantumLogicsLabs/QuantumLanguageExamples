# Stirling numbers of the second kind and Bell numbers.
def stirling2(n, k, memo = {})
  return 1 if n == k
  return 0 if k.zero? || k > n
  memo[[n, k]] ||= k * stirling2(n - 1, k, memo) + stirling2(n - 1, k - 1, memo)
end

def bell_triangle(rows)
  tri = [[1]]
  (rows - 1).times do
    row = [tri.last.last]
    tri.last.each { |x| row << row.last + x }
    tri << row
  end
  tri
end

(1..6).each { |n| puts (1..n).map { |k| stirling2(n, k).to_s.rjust(4) }.join }
bells = (0..10).map { |n| (0..n).sum { |k| stirling2(n, k) } }
puts bells.inspect
puts bell_triangle(8).map(&:first).inspect
puts "ways to partition 4 people: #{bells[4]}"
