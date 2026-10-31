# A hash table with separate chaining and resizing.
class ChainedHash
  attr_reader :size

  def initialize(buckets = 4)
    @buckets = Array.new(buckets) { [] }
    @size = 0
  end

  def []=(key, value)
    bucket = bucket_for(key)
    pair = bucket.find { |k, _| k == key }
    if pair
      pair[1] = value
    else
      bucket << [key, value]
      @size += 1
      resize if @size > @buckets.size * 2
    end
  end

  def [](key) = bucket_for(key).find { |k, _| k == key }&.last
  def load_factor = (@size.to_f / @buckets.size).round(2)
  def bucket_sizes = @buckets.map(&:size)

  private

  def index(key, n) = key.to_s.each_char.reduce(7) { |h, c| (h * 31 + c.ord) % 1_000_003 } % n
  def bucket_for(key) = @buckets[index(key, @buckets.size)]

  def resize
    old = @buckets.flatten(1)
    @buckets = Array.new(@buckets.size * 2) { [] }
    old.each { |k, v| @buckets[index(k, @buckets.size)] << [k, v] }
  end
end

h = ChainedHash.new
%w[apple banana cherry date elder fig grape honeydew kiwi lemon mango].each_with_index { |w, i| h[w] = i }
h["apple"] = 100
puts h["apple"], h["kiwi"], h["zucchini"].inspect
puts "size #{h.size}, load #{h.load_factor}, buckets #{h.bucket_sizes.inspect}"
