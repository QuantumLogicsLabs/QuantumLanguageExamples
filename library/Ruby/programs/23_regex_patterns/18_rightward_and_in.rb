# One-line pattern matching: => for destructuring, in for testing.
config = { server: { host: "example.com", ports: [80, 443] }, debug: false }
config => { server: { host:, ports: [first_port, *] } }
puts "host #{host}, first port #{first_port}"

puts((config in { debug: false }))
puts((config in { server: { ports: [_, _, _] } }))
puts(([1, [2, 3]] in [Integer, [_, Integer]]))

point = { x: 3, y: 4 }
point => { x:, y: }
puts Math.sqrt(x * x + y * y)

begin
  { name: "x" } => { age: }
rescue NoMatchingPatternKeyError => e
  puts "no match: #{e.class}"
end

values = [[1, "one"], [2, "two"], [:bad], [3, "three"]]
puts values.select { |v| v in [Integer, String] }.map(&:last).inspect
