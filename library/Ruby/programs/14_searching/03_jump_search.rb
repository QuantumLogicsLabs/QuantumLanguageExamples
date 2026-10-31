# Jump search in blocks of sqrt(n).
def jump_search(arr, target)
  n = arr.size
  step = Integer.sqrt(n)
  prev = 0
  jumps = 0
  while arr[[step, n].min - 1] < target
    prev = step
    step += Integer.sqrt(n)
    jumps += 1
    return [nil, jumps] if prev >= n
  end
  (prev...[step, n].min).each { |i| return [i, jumps] if arr[i] == target }
  [nil, jumps]
end

data = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]
[55, 0, 610, 4, 1000].each do |t|
  idx, jumps = jump_search(data, t)
  puts "#{t}: #{idx.inspect} (#{jumps} jumps)"
end
