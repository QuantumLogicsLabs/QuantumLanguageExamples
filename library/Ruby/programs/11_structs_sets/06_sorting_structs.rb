# Sorting and querying a list of structs.
Employee = Struct.new(:name, :dept, :salary, :years)
staff = [
  Employee.new("Ana", "eng", 120, 6),
  Employee.new("Ben", "ops", 85, 3),
  Employee.new("Cy", "eng", 98, 2),
  Employee.new("Dee", "sales", 70, 8),
  Employee.new("Eli", "ops", 92, 5),
  Employee.new("Fay", "eng", 120, 9)
]

puts staff.sort_by { |e| [-e.salary, e.name] }.map(&:name).join(" ")
staff.group_by(&:dept).sort.each do |dept, members|
  avg = members.sum(&:salary).fdiv(members.size).round(1)
  puts "#{dept.ljust(6)} #{members.size} people, avg #{avg}, senior #{members.max_by(&:years).name}"
end
puts staff.select { |e| e.years > 4 }.map(&:name).inspect
puts staff.partition { |e| e.dept == "eng" }.map { |g| g.sum(&:salary) }.inspect
puts staff.find { |e| e.salary < 80 }&.name
puts staff.minmax_by(&:years).map(&:name).inspect
