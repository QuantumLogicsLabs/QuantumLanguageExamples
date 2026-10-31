# A multiplication table with aligned columns.
size = 9
width = (size * size).to_s.length + 1

print " " * (width + 1)
(1..size).each { |c| print c.to_s.rjust(width) }
puts
puts "-" * (width * (size + 1) + 1)

(1..size).each do |r|
  print r.to_s.rjust(width) + "|"
  (1..size).each { |c| print (r * c).to_s.rjust(width) }
  puts
end

diagonal = (1..size).map { |i| i * i }
puts "Squares on the diagonal: #{diagonal.inspect}"
