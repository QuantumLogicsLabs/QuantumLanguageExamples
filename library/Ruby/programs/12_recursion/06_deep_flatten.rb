# Flattening, summing and measuring nested structures.
def deep_flatten(obj) = obj.is_a?(Array) ? obj.flat_map { |x| deep_flatten(x) } : [obj]
def depth(obj) = obj.is_a?(Array) ? 1 + (obj.map { |x| depth(x) }.max || 0) : 0
def deep_sum(obj) = obj.is_a?(Array) ? obj.sum { |x| deep_sum(x) } : obj
def deep_map(obj, &f) = obj.is_a?(Array) ? obj.map { |x| deep_map(x, &f) } : f.call(obj)

nested = [1, [2, [3, [4, [5]]]], [6, 7], [], [[8]]]
puts deep_flatten(nested).inspect
puts depth(nested)
puts depth([])
puts deep_sum(nested)
puts deep_map(nested) { |x| x * 10 }.inspect
puts deep_flatten(nested) == nested.flatten
