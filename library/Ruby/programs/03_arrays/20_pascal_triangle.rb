# Pascal's triangle and its properties.
def pascal(rows)
  triangle = [[1]]
  (rows - 1).times do
    prev = triangle.last
    triangle << [1] + prev.each_cons(2).map { |a, b| a + b } + [1]
  end
  triangle
end

tri = pascal(10)
width = tri.last.join(" ").length
tri.each { |row| puts row.join(" ").center(width) }
puts "Row sums: #{tri.map(&:sum).inspect}"
puts "Row 9 is symmetric: #{tri[9] == tri[9].reverse}"
puts "C(9, 4) = #{tri[9][4]}"
puts "Odd entries per row: #{tri.map { |r| r.count(&:odd?) }.inspect}"
