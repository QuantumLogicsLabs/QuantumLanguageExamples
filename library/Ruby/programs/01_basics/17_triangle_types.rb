# Classifies triangles by sides and by angles.
def kind_by_sides(a, b, c)
  return "invalid" unless a + b > c && a + c > b && b + c > a
  if a == b && b == c then "equilateral"
  elsif a == b || b == c || a == c then "isosceles"
  else "scalene"
  end
end

def kind_by_angles(a, b, c)
  x, y, z = [a, b, c].sort
  sum = x * x + y * y
  if sum == z * z then "right"
  elsif sum > z * z then "acute"
  else "obtuse"
  end
end

def area(a, b, c)
  s = (a + b + c) / 2.0
  Math.sqrt(s * (s - a) * (s - b) * (s - c))
end

[[3, 4, 5], [2, 2, 2], [5, 5, 8], [7, 8, 9], [1, 2, 3], [6, 6, 11]].each do |a, b, c|
  sides = kind_by_sides(a, b, c)
  if sides == "invalid"
    puts "#{a}, #{b}, #{c}: not a triangle"
  else
    puts "#{a}, #{b}, #{c}: #{sides}, #{kind_by_angles(a, b, c)}, area #{area(a, b, c).round(3)}"
  end
end
