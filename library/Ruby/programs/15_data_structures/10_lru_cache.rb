# A least-recently-used cache built on Hash ordering.
class LRUCache
  attr_reader :hits, :misses

  def initialize(capacity)
    @capacity = capacity
    @store = {}
    @hits = @misses = 0
  end

  def get(key)
    if @store.key?(key)
      @hits += 1
      value = @store.delete(key)
      @store[key] = value
    else
      @misses += 1
      nil
    end
  end

  def put(key, value)
    @store.delete(key)
    @store[key] = value
    @store.delete(@store.first[0]) if @store.size > @capacity
    self
  end

  def keys = @store.keys
end

cache = LRUCache.new(3)
cache.put(:a, 1).put(:b, 2).put(:c, 3)
puts cache.get(:a)
cache.put(:d, 4)
puts cache.keys.inspect
puts cache.get(:b).inspect
cache.put(:e, 5)
puts cache.keys.inspect
%i[a c d x e].each { |k| cache.get(k) }
puts "hits #{cache.hits}, misses #{cache.misses}"
