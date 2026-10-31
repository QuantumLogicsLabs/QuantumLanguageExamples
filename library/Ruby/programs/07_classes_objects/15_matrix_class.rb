# A Matrix class with [] access, each and multiplication.
class Mat
  include Enumerable
  attr_reader :rows, :cols

  def initialize(rows, cols, &block)
    @rows, @cols = rows, cols
    @data = Array.new(rows) { |r| Array.new(cols) { |c| block ? block.call(r, c) : 0 } }
  end

  def self.identity(n) = new(n, n) { |r, c| r == c ? 1 : 0 }
  def [](r, c) = @data[r][c]
  def []=(r, c, v)
    @data[r][c] = v
  end
  def each(&block) = @data.flatten.each(&block)
  def transpose = Mat.new(cols, rows) { |r, c| self[c, r] }

  def *(other)
    Mat.new(rows, other.cols) { |r, c| (0...cols).sum { |k| self[r, k] * other[k, c] } }
  end

  def to_s = @data.map { |row| row.map { |v| v.to_s.rjust(4) }.join }.join("\n")
end

a = Mat.new(2, 3) { |r, c| r * 3 + c + 1 }
puts a
puts "--"
puts a.transpose
puts "--"
puts a * a.transpose
puts "--"
puts (Mat.identity(3) * a.transpose).to_a.inspect
a[0, 0] = 100
puts a.max
puts a.sum
puts a.sort.inspect
