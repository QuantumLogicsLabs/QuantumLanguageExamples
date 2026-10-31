# Finding values closest to a target.
def closest(sorted, target)
  i = sorted.bsearch_index { |x| x >= target } || sorted.size
  candidates = [i - 1, i].select { |j| j.between?(0, sorted.size - 1) }
  sorted[candidates.min_by { |j| [(sorted[j] - target).abs, sorted[j]] }]
end

def k_closest(sorted, k, target) = sorted.min_by(k) { |x| [(x - target).abs, x] }.sort

def closest_pair_sum(a, b, target)
  a.product(b).min_by { |x, y| [(x + y - target).abs, x, y] }
end

data = [1, 4, 7, 10, 13, 20, 25]
[0, 8, 11.5, 22, 100].each { |t| puts "closest to #{t}: #{closest(data, t)}" }
puts k_closest(data, 3, 9).inspect
puts closest_pair_sum([1, 4, 5, 7], [10, 20, 30, 40], 32).inspect
