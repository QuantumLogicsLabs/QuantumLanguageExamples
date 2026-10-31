# next, break and loop do.
puts "Odd numbers below 15, skipping multiples of 5:"
(1...15).each do |i|
  next if i.even?
  next if (i % 5).zero?
  print i, " "
end
puts

first_big = nil
[3, 8, 12, 40, 7, 99].each do |n|
  if n > 30
    first_big = n
    break
  end
end
puts "First number above 30: #{first_big}"

found = [4, 9, 16, 25].each_with_index do |v, i|
  break "found #{v} at #{i}" if v > 10
end
puts found

i = 0
loop do
  i += 1
  next if i < 3
  puts "loop at #{i}"
  break if i >= 5
end
