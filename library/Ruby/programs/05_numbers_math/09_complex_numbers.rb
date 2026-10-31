# Complex arithmetic.
z = Complex(3, 4)
w = Complex(1, -2)
puts z
puts z + w
puts z - w
puts z * w
puts z / w
puts z.abs
puts z.conjugate
puts z.real
puts z.imaginary
puts z.rectangular.inspect
puts Complex(0, 1)**2
roots = [1, -3, 2]
a, b, c = roots
disc = b * b - 4 * a * c
puts "Roots of x^2 - 3x + 2: #{(-b + Math.sqrt(disc)) / (2 * a)}, #{(-b - Math.sqrt(disc)) / (2 * a)}"
d2 = Complex(-16, 0)
puts "sqrt(-16) = #{Complex(0, Math.sqrt(-d2.real))}"
