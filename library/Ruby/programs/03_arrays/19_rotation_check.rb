# Detecting rotations of arrays and strings.
def rotation?(a, b)
  return false unless a.size == b.size
  return true if a.empty?
  (0...a.size).any? { |k| a.rotate(k) == b }
end

def string_rotation?(a, b)
  a.length == b.length && (a + a).include?(b)
end

puts rotation?([1, 2, 3, 4], [3, 4, 1, 2])
puts rotation?([1, 2, 3, 4], [4, 3, 2, 1])
puts rotation?([], [])
puts string_rotation?("waterbottle", "erbottlewat")
puts string_rotation?("hello", "lohel")
puts string_rotation?("hello", "olleh")

min_rotation = (0...5).map { |k| "bcaba".chars.rotate(k).join }.min
puts "Lexicographically smallest rotation of bcaba: #{min_rotation}"
