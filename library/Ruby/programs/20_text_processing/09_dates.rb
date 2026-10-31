# Date arithmetic with the Date class.
require "date"

d = Date.new(2024, 2, 28)
puts d
puts d + 1
puts d + 2
puts d.leap?
puts d.strftime("%A, %d %B %Y")
puts d.yday
puts d.cwday
puts (Date.new(2024, 12, 25) - Date.new(2024, 1, 1)).to_i
puts Date.new(2024, 1, 31) >> 1
puts Date.parse("2023-07-04").strftime("%b %-d, %Y")
puts (Date.new(2024, 3, 1)..Date.new(2024, 3, 10)).count { |x| x.saturday? || x.sunday? }
puts Date.valid_date?(2023, 2, 29)

birthday = Date.new(1990, 6, 15)
on = Date.new(2024, 6, 14)
age = on.year - birthday.year - (on < Date.new(on.year, birthday.month, birthday.day) ? 1 : 0)
puts "age on #{on}: #{age}"
fridays_13 = (2024..2025).flat_map { |y| (1..12).map { |m| Date.new(y, m, 13) } }.select(&:friday?)
puts fridays_13.map(&:to_s).inspect
