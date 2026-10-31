# A set of disjoint intervals with merging on insert.
class IntervalSet
  def initialize = @intervals = []

  def add(lo, hi)
    merged = [lo, hi]
    keep = []
    @intervals.each do |a, b|
      if b < merged[0] - 1 || a > merged[1] + 1
        keep << [a, b]
      else
        merged = [[a, merged[0]].min, [b, merged[1]].max]
      end
    end
    @intervals = (keep << merged).sort
    self
  end

  def include?(x) = @intervals.any? { |a, b| x.between?(a, b) }
  def covered = @intervals.sum { |a, b| b - a + 1 }
  def gaps = @intervals.each_cons(2).map { |(_, b), (c, _)| [b + 1, c - 1] }
  def to_s = @intervals.map { |a, b| a == b ? a.to_s : "#{a}-#{b}" }.join(",")
end

s = IntervalSet.new
[[1, 3], [10, 12], [5, 6], [4, 4], [20, 25], [11, 15], [7, 8]].each do |lo, hi|
  s.add(lo, hi)
  puts "add #{lo}-#{hi}: #{s}"
end
puts "covered #{s.covered}, gaps #{s.gaps.inspect}, has 16? #{s.include?(16)}"
