# Truth tables, truthiness and safe navigation.
puts "a     b     and   or    xor"
[true, false].each do |a|
  [true, false].each do |b|
    puts format("%-5s %-5s %-5s %-5s %-5s", a, b, a && b, a || b, a ^ b)
  end
end

[0, "", [], nil, false, "no"].each do |v|
  puts "#{v.inspect.ljust(6)} is #{v ? 'truthy' : 'falsy'}"
end

user = nil
puts "Name length: #{user&.length.inspect}"
user = "Grace"
puts "Name length: #{user&.length.inspect}"

default = nil
setting = default || "fallback"
puts "Setting: #{setting}"
counter = nil
counter ||= 10
counter &&= counter + 1
puts "Counter: #{counter}"
