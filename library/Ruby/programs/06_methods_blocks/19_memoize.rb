# A generic memoize helper based on closures.
def memoize(fn)
  cache = {}
  hits = 0
  wrapped = lambda do |*args|
    if cache.key?(args)
      hits += 1
      cache[args]
    else
      cache[args] = fn.call(*args)
    end
  end
  stats = -> { { entries: cache.size, hits: hits } }
  [wrapped, stats]
end

slow_square = ->(n) { (1..n).sum { n } }
fast_square, stats = memoize(slow_square)
[12, 7, 12, 12, 7, 30].each { |n| puts "#{n}^2 = #{fast_square.(n)}" }
puts stats.call.inspect

paths = nil
paths, path_stats = memoize(->(r, c) { r.zero? || c.zero? ? 1 : paths.(r - 1, c) + paths.(r, c - 1) })
puts "Grid paths 16x16: #{paths.(16, 16)}"
puts path_stats.call.inspect
