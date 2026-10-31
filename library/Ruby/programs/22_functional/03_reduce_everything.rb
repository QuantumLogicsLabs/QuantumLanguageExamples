# Implementing common operations with reduce alone.
def my_map(xs, &f) = xs.reduce([]) { |acc, x| acc << f.(x) }
def my_select(xs, &p) = xs.reduce([]) { |acc, x| p.(x) ? acc << x : acc }
def my_flatten(xs) = xs.reduce([]) { |acc, x| x.is_a?(Array) ? acc + my_flatten(x) : acc << x }
def my_reverse(xs) = xs.reduce([]) { |acc, x| [x] + acc }
def my_max(xs) = xs.reduce { |a, b| b > a ? b : a }
def my_group(xs, &k) = xs.reduce({}) { |h, x| h.merge(k.(x) => (h[k.(x)] || []) + [x]) }
def my_zip(a, b) = a.each_index.reduce([]) { |acc, i| acc << [a[i], b[i]] }
def my_uniq(xs) = xs.reduce([]) { |acc, x| acc.include?(x) ? acc : acc << x }

nums = [5, 3, 8, 3, 1, 8, 9]
puts my_map(nums) { |x| x * 10 }.inspect
puts my_select(nums, &:odd?).inspect
puts my_flatten([1, [2, [3, [4]]], 5]).inspect
puts my_reverse(nums).inspect
puts my_max(nums)
puts my_group(nums, &:even?).inspect
puts my_zip(%w[a b c], [1, 2, 3]).inspect
puts my_uniq(nums).inspect
