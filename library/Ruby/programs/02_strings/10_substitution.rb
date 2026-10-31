# sub and gsub with strings, hashes and blocks.
text = "The cat sat on the mat with another cat."

puts text.sub("cat", "dog")
puts text.gsub("cat", "dog")
puts text.gsub(/\b(\w)at\b/) { "#{$1.upcase}AT" }
puts text.gsub(/[aeiou]/, "a" => "4", "e" => "3", "o" => "0")
puts text.gsub(/\s+/, "_")

template = "Dear {name}, your order {order} ships on {date}."
values = { "name" => "Ana", "order" => "#4521", "date" => "Monday" }
puts template.gsub(/\{(\w+)\}/) { values[$1] }

phone = "555-123-4567"
puts phone.gsub(/\d(?=\d{4})/, "*")
puts "snake_case_name".gsub(/_(\w)/) { $1.upcase }
puts "CamelCaseName".gsub(/([a-z])([A-Z])/, '\1_\2').downcase
