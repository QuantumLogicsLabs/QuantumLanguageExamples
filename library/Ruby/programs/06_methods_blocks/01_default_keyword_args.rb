# Default values and keyword arguments.
def greet(name, greeting = "Hello", punctuation: "!", shout: false)
  text = "#{greeting}, #{name}#{punctuation}"
  shout ? text.upcase : text
end

puts greet("Ana")
puts greet("Ben", "Hi")
puts greet("Cy", punctuation: "?")
puts greet("Dee", "Hey", shout: true)

def create_user(name:, role: "member", active: true)
  "#{name} (#{role}#{active ? '' : ', inactive'})"
end

puts create_user(name: "eve")
puts create_user(role: "admin", name: "fay")
puts create_user(name: "gus", active: false)

begin
  create_user(role: "x")
rescue ArgumentError => e
  puts "Error: #{e.message}"
end

def box(width = 4, height = width) = "#{width}x#{height}"
puts box, box(6), box(2, 3)
