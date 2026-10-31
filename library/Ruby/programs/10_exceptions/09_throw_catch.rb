# Leaving nested loops with throw and catch.
grid = [
  [1, 3, 5, 7],
  [9, 11, 12, 15],
  [17, 19, 21, 23]
]

found = catch(:found) do
  grid.each_with_index do |row, r|
    row.each_with_index do |v, c|
      throw :found, [r, c] if v.even?
    end
  end
  nil
end
puts "First even at #{found.inspect}"

result = catch(:done) do
  (1..10).each do |i|
    (1..10).each do |j|
      throw :done, "#{i} x #{j} = #{i * j}" if i * j == 42
    end
  end
  "not found"
end
puts result

def search(words, target)
  catch(:stop) do
    words.each { |w| throw :stop, "found #{w}" if w == target }
    "missing #{target}"
  end
end
puts search(%w[a b c], "b")
puts search(%w[a b c], "z")
