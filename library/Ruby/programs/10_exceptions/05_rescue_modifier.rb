# Inline rescue modifiers and defaults.
inputs = ["42", "x", "3.7", nil, "-8"]
inputs.each do |s|
  n = Integer(s) rescue "invalid"
  puts "#{s.inspect} -> #{n.inspect}"
end

h = { a: 1 }
puts (h.fetch(:b) rescue "default b")
puts [1, 2, 3].sum / 0 rescue puts "cannot divide by zero"
ratio = (10 / 0 rescue Float::INFINITY)
puts ratio
safe = ->(f) { f.call rescue $!.class.name }
puts safe.(-> { nil.upcase })
puts safe.(-> { "a" + 1 })
puts safe.(-> { :ok })
