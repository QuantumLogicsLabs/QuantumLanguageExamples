# Maps each word to the lines it appears on.
lines = [
  "the cat sat on the mat",
  "the dog chased the cat",
  "a bird sat on the dog",
  "the end"
]

index = Hash.new { |h, k| h[k] = [] }
lines.each_with_index do |line, i|
  line.split.uniq.each { |word| index[word] << i + 1 }
end

index.sort.each { |word, nums| puts "#{word.ljust(7)} #{nums.join(', ')}" }
common = index.select { |_, nums| nums.size >= 3 }.keys
puts "On 3+ lines: #{common.inspect}"
