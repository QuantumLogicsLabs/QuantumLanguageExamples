# Leap years by the Gregorian rules.
def leap?(year)
  (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
end

[1900, 2000, 2004, 2023, 2024, 2100, 2400].each do |y|
  puts "#{y}: #{leap?(y) ? 'leap' : 'common'}"
end

leaps = (1990..2030).select { |y| leap?(y) }
puts "Leap years 1990-2030: #{leaps.join(' ')}"
puts "Count: #{leaps.size}"

days = (2020..2025).map { |y| [y, leap?(y) ? 366 : 365] }
days.each { |y, d| puts "#{y} has #{d} days" }
puts "Total days 2020-2025: #{days.sum { |_, d| d }}"
