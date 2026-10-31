# Recursive merge sort with an inversion count.
def merge_sort(arr)
  return [arr, 0] if arr.size <= 1
  mid = arr.size / 2
  left, inv_l = merge_sort(arr[0...mid])
  right, inv_r = merge_sort(arr[mid..])
  merged = []
  inversions = inv_l + inv_r
  until left.empty? || right.empty?
    if left.first <= right.first
      merged << left.shift
    else
      inversions += left.size
      merged << right.shift
    end
  end
  [merged + left + right, inversions]
end

[[5, 2, 9, 1, 5, 6], [1, 2, 3, 4], [4, 3, 2, 1], [38, 27, 43, 3, 9, 82, 10], []].each do |a|
  sorted, inv = merge_sort(a)
  puts "#{a.inspect} -> #{sorted.inspect} (#{inv} inversions)"
end
