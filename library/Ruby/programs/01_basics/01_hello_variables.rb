# Variables, interpolation and the classes of basic values.
name = "Ada"
age = 36
height = 1.68
languages = ["Ruby", "C", "Lisp"]
married = true

puts "Hello, #{name}!"
puts "#{name} is #{age} years old and #{height} m tall."
puts "Next year #{name} will be #{age + 1}."
puts "Favourite languages: #{languages.join(', ')}"
puts "Married? #{married}"

[name, age, height, languages, married, nil, :symbol].each do |value|
  puts "#{value.inspect} is a #{value.class}"
end
