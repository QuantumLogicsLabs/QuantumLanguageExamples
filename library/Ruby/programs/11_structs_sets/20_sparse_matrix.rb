# A sparse matrix stored as a hash of coordinates.
class SparseMatrix
  attr_reader :rows, :cols

  def initialize(rows, cols)
    @rows, @cols = rows, cols
    @cells = {}
  end

  def [](r, c) = @cells.fetch([r, c], 0)

  def []=(r, c, v)
    v.zero? ? @cells.delete([r, c]) : @cells[[r, c]] = v
  end

  def nonzero = @cells.size
  def density = (nonzero.to_f / (rows * cols)).round(4)

  def *(other)
    result = SparseMatrix.new(rows, other.cols)
    @cells.each do |(r, k), v|
      (0...other.cols).each do |c|
        w = other[k, c]
        result[r, c] = result[r, c] + v * w unless w.zero?
      end
    end
    result
  end

  def to_s = (0...rows).map { |r| (0...cols).map { |c| self[r, c].to_s.rjust(3) }.join }.join("\n")
end

m = SparseMatrix.new(4, 4)
m[0, 0] = 2
m[1, 3] = 5
m[3, 1] = -1
m[2, 2] = 4
puts m
puts "nonzero #{m.nonzero}, density #{m.density}"
sq = m * m
puts sq
m[2, 2] = 0
puts "after clearing: #{m.nonzero}"
