# Generating permutations recursively.
def permutations(items)
  return [items] if items.size <= 1
  items.each_with_index.flat_map do |item, i|
    rest = items[0...i] + items[i + 1..]
    permutations(rest).map { |p| [item] + p }
  end
end

def unique_permutations(chars)
  return [""] if chars.empty?
  chars.uniq.flat_map do |c|
    rest = chars.dup
    rest.delete_at(rest.index(c))
    unique_permutations(rest).map { |p| c + p }
  end
end

puts permutations([1, 2, 3]).map(&:join).join(" ")
puts permutations(%w[a b c d]).size
puts unique_permutations("aab".chars).inspect
puts unique_permutations("moon".chars).size
puts permutations([1, 2, 3]) == [1, 2, 3].permutation.to_a
