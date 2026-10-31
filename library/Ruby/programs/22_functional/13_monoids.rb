# Combining values with monoids.
Monoid = Struct.new(:name, :empty, :combine) do
  def concat(xs) = xs.reduce(empty) { |a, b| combine.(a, b) }
end

SUM = Monoid.new("sum", 0, ->(a, b) { a + b })
PRODUCT = Monoid.new("product", 1, ->(a, b) { a * b })
MAX = Monoid.new("max", -Float::INFINITY, ->(a, b) { [a, b].max })
STRING = Monoid.new("string", "", ->(a, b) { a + b })
ALL = Monoid.new("all", true, ->(a, b) { a && b })
MERGE = Monoid.new("merge", {}, ->(a, b) { a.merge(b) { |_, x, y| x + y } })

def pair(m1, m2) = Monoid.new("#{m1.name}x#{m2.name}", [m1.empty, m2.empty], ->(a, b) { [m1.combine.(a[0], b[0]), m2.combine.(a[1], b[1])] })

nums = [3, 1, 4, 1, 5, 9, 2, 6]
[SUM, PRODUCT, MAX].each { |m| puts "#{m.name}: #{m.concat(nums)}" }
puts STRING.concat(%w[mon oid s])
puts ALL.concat(nums.map(&:positive?))
puts MERGE.concat([{ a: 1 }, { b: 2, a: 3 }, { b: 1 }]).inspect
stats = pair(SUM, MAX).concat(nums.map { |x| [x, x] })
puts "sum and max in one pass: #{stats.inspect}"
puts SUM.concat([]), PRODUCT.concat([])
chunks = nums.each_slice(3).map { |c| SUM.concat(c) }
puts "chunked sum #{SUM.concat(chunks)} == #{SUM.concat(nums)}"
