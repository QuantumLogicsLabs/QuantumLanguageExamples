# case expressions over ranges, classes and lists.
def describe_age(age)
  case age
  when 0...2 then "baby"
  when 2...13 then "child"
  when 13...20 then "teenager"
  when 20...65 then "adult"
  else "senior"
  end
end

def describe(value)
  case value
  when Integer then "integer #{value}"
  when Float then "float #{value}"
  when String, Symbol then "text #{value}"
  when Array then "array of #{value.size}"
  when nil then "nothing"
  else "something else"
  end
end

[1, 8, 16, 35, 70].each { |a| puts "#{a}: #{describe_age(a)}" }
[42, 3.5, "hi", :ok, [1, 2], nil, { a: 1 }].each { |v| puts describe(v) }

day = "Sat"
kind = case day
       when "Sat", "Sun" then "weekend"
       else "weekday"
       end
puts "#{day} is a #{kind}"
