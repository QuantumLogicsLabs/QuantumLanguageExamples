# Group words into anagram sets (grouped by sorted-character key), and
# a companion function generating all unique permutations of a string.
def group_anagrams(words)
  groups = Hash.new { |h, k| h[k] = [] }
  words.each do |word|
    key = word.chars.sort.join
    groups[key] << word
  end
  groups.values
end

def permutations(string)
  return [""] if string.empty?
  first = string[0]
  rest_perms = permutations(string[1..-1])
  result = []
  rest_perms.each do |perm|
    (0..perm.length).each { |i| result << perm[0...i] + first + perm[i..-1] }
  end
  result.uniq
end

if __FILE__ == $0
  words = %w[eat tea tan ate nat bat]
  puts "Anagram groups: #{group_anagrams(words)}"
  puts "Permutations of 'abc': #{permutations('abc')}"
end
