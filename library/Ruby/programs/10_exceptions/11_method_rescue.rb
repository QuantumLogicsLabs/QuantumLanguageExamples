# rescue and ensure attached directly to def bodies.
def read_setting(settings, key)
  value = settings.fetch(key)
  Integer(value)
rescue KeyError
  puts "  #{key}: missing, using 0"
  0
rescue ArgumentError
  puts "  #{key}: not a number (#{value.inspect}), using -1"
  -1
ensure
  puts "  checked #{key}"
end

settings = { "timeout" => "30", "retries" => "three" }
%w[timeout retries port].each do |k|
  puts "#{k} = #{read_setting(settings, k)}"
end

total = [1, 2, 3].sum do |n|
  10 / (n - 2)
rescue ZeroDivisionError
  0
end
puts "Block rescue total: #{total}"
