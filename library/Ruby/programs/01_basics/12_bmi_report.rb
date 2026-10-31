# Body mass index for a few people, with categories.
Person = Struct.new(:name, :weight_kg, :height_m)

def bmi(person)
  person.weight_kg / (person.height_m**2)
end

def category(value)
  if value < 18.5 then "underweight"
  elsif value < 25 then "normal"
  elsif value < 30 then "overweight"
  else "obese"
  end
end

people = [
  Person.new("Lena", 54.0, 1.65),
  Person.new("Omar", 82.5, 1.80),
  Person.new("Ravi", 97.0, 1.75),
  Person.new("Sue", 47.5, 1.62)
]

people.each do |p|
  value = bmi(p)
  puts format("%-5s %5.1f kg %4.2f m  BMI %5.2f  %s", p.name, p.weight_kg, p.height_m, value, category(value))
end
avg = people.sum { |p| bmi(p) } / people.size
puts "Average BMI: #{avg.round(2)}"
