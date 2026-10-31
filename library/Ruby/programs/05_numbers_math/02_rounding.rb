# Rounding floats in different directions.
values = [3.14159, 2.5, -2.5, 7.75, -7.75, 1234.5678]
values.each do |v|
  puts "#{v}: round #{v.round}, floor #{v.floor}, ceil #{v.ceil}, truncate #{v.truncate}, round(2) #{v.round(2)}"
end
puts 1234.5678.round(-2)
puts 1234.round(-2)
puts 15.round(-1)
puts 25.round(-1)
puts 2.675.round(2)
puts 10.0.to_i
puts 9.99.to_i
puts (0.1 + 0.2).round(10)
puts 0.1 + 0.2
puts (0.1 + 0.2 == 0.3)
puts ((0.1 + 0.2) - 0.3).abs < Float::EPSILON
