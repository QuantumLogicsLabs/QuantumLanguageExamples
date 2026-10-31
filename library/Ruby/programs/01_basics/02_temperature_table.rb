# A Celsius to Fahrenheit and Kelvin conversion table.
def to_fahrenheit(c)
  c * 9.0 / 5 + 32
end

def to_kelvin(c)
  c + 273.15
end

puts "Celsius  Fahrenheit  Kelvin"
puts "-" * 28
(-20..40).step(10) do |c|
  puts format("%7d  %10.1f  %6.2f", c, to_fahrenheit(c), to_kelvin(c))
end

boiling = 100
puts
puts "Water boils at #{boiling}C = #{to_fahrenheit(boiling)}F"
puts "Body temperature 37C = #{to_fahrenheit(37).round(1)}F"
