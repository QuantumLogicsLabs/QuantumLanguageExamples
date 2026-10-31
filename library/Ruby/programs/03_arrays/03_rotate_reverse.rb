# Rotating and reversing arrays.
letters = %w[a b c d e f]
puts letters.rotate.inspect
puts letters.rotate(2).inspect
puts letters.rotate(-1).inspect
puts letters.reverse.inspect

def rotate_right(arr, k)
  k %= arr.size
  arr[-k..] + arr[0...-k]
end
puts rotate_right(letters, 2).inspect

def reverse_in_place(arr)
  i, j = 0, arr.size - 1
  while i < j
    arr[i], arr[j] = arr[j], arr[i]
    i += 1
    j -= 1
  end
  arr
end
puts reverse_in_place([1, 2, 3, 4, 5]).inspect

(0...letters.size).each { |k| puts letters.rotate(k).join }
