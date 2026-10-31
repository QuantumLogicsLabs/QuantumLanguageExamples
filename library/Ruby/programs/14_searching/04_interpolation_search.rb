# Interpolation search on uniformly spread data.
def interpolation_search(arr, target)
  lo, hi = 0, arr.size - 1
  probes = 0
  while lo <= hi && target.between?(arr[lo], arr[hi])
    probes += 1
    return [lo, probes] if arr[lo] == arr[hi]
    pos = lo + ((target - arr[lo]) * (hi - lo) / (arr[hi] - arr[lo]))
    return [pos, probes] if arr[pos] == target
    arr[pos] < target ? lo = pos + 1 : hi = pos - 1
  end
  [nil, probes]
end

uniform = (0...100).map { |i| i * 10 + 3 }
skewed = (1..20).map { |i| i**3 }
[[uniform, 503], [uniform, 993], [uniform, 7], [skewed, 4913], [skewed, 8000], [skewed, 100]].each do |arr, t|
  idx, probes = interpolation_search(arr, t)
  puts "#{t}: index #{idx.inspect} in #{probes} probes"
end
