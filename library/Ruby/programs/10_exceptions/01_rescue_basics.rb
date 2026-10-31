# begin / rescue / else / ensure.
def safe_divide(a, b)
  result = a / b
rescue ZeroDivisionError => e
  puts "  rescued #{e.class}: #{e.message}"
  nil
else
  puts "  no error"
  result
ensure
  puts "  ensure always runs"
end

[[10, 2], [1, 0], [7.0, 0]].each do |a, b|
  puts "#{a} / #{b}:"
  puts "  => #{safe_divide(a, b).inspect}"
end

begin
  Integer("forty-two")
rescue ArgumentError => e
  puts "Bad number: #{e.message}"
end

value = begin
  [1, 2, 3].fetch(10)
rescue IndexError
  :missing
end
puts value.inspect
