# filter_map, compact and sum with transformations.
inputs = ["12", "x", "7", "", "3.5", "-4", nil, "40"]
ints = inputs.filter_map { |s| Integer(s, exception: false) if s }
puts ints.inspect
floats = inputs.compact.filter_map { |s| Float(s, exception: false) }
puts floats.inspect
puts inputs.compact.reject(&:empty?).size

emails = ["ana@example.com", "bad-address", "ben@mail.org", "cy@", "dee@site.net"]
domains = emails.filter_map { |e| e.split("@")[1] if e.match?(/\A[^@]+@[^@]+\.\w+\z/) }
puts domains.inspect

squares_of_evens = (1..10).filter_map { |n| n * n if n.even? }
puts squares_of_evens.inspect
puts [nil, [nil, 1], 2].compact.inspect
puts({ a: nil, b: 2, c: nil }.compact.inspect)
