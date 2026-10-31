# Find patterns and the pin operator.
def find_triple(list)
  case list
  in [*, x, ^x, ^x, *post] then "#{x} repeated three times, #{post.size} items after"
  else "no triple"
  end
end

puts find_triple([1, 2, 2, 2, 3, 4])
puts find_triple([5, 5, 6, 6])
puts find_triple(%w[a b b b])

expected = 42
[42, 41, { answer: 42 }].each do |v|
  result = case v
           in ^expected then "exactly the expected value"
           in { answer: ^expected } then "answer field matches"
           else "no match"
           end
  puts "#{v.inspect}: #{result}"
end

records = [{ name: "ana", role: "admin" }, { name: "ben", role: "dev" }, { name: "cy", role: "admin" }]
case records
in [*, { role: "dev", name: }, *]
  puts "first dev: #{name}"
end
limit = 2
second = case [1, 2]
         in [_, ^limit] then "second is the limit"
         else "no"
         end
puts second
