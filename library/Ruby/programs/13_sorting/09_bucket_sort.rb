# Bucket sort for floats in [0, 1).
def bucket_sort(values, buckets = 5)
  groups = Array.new(buckets) { [] }
  values.each { |v| groups[(v * buckets).floor] << v }
  groups.each_with_index { |g, i| puts "bucket #{i}: #{g.inspect}" }
  groups.flat_map(&:sort)
end

data = [0.42, 0.32, 0.23, 0.52, 0.25, 0.47, 0.51, 0.97, 0.01, 0.78]
puts bucket_sort(data).inspect
puts bucket_sort(data) == data.sort
