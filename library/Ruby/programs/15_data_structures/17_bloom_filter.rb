# A Bloom filter with deterministic hash functions.
class BloomFilter
  def initialize(bits, hashes)
    @bits = Array.new(bits, false)
    @k = hashes
  end

  def add(item) = positions(item).each { |p| @bits[p] = true }
  def maybe_include?(item) = positions(item).all? { |p| @bits[p] }
  def fill_ratio = (@bits.count(true).to_f / @bits.size).round(3)

  private

  def positions(item)
    s = item.to_s
    h1 = s.each_char.reduce(5381) { |h, c| (h * 33 + c.ord) % 4_294_967_296 }
    h2 = s.each_char.reduce(0) { |h, c| (h * 131 + c.ord + 7) % 4_294_967_296 }
    Array.new(@k) { |i| (h1 + i * h2) % @bits.size }
  end
end

bf = BloomFilter.new(128, 3)
words = %w[apple banana cherry date elder fig grape]
words.each { |w| bf.add(w) }
puts words.all? { |w| bf.maybe_include?(w) }
probes = %w[apricot blueberry coconut durian kiwi lemon mango nectarine olive peach]
false_pos = probes.select { |w| bf.maybe_include?(w) }
puts "fill ratio #{bf.fill_ratio}, false positives #{false_pos.size}/#{probes.size} #{false_pos.inspect}"
