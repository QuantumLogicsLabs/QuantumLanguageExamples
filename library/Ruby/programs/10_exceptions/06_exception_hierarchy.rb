# Where common exceptions sit in the hierarchy.
[ZeroDivisionError, KeyError, NoMethodError, TypeError, FrozenError, StopIteration, RuntimeError].each do |klass|
  chain = klass.ancestors.take_while { |a| a != Object }.select { |a| a.is_a?(Class) }
  puts chain.join(" < ")
end

def classify
  yield
  "no error"
rescue ZeroDivisionError, FloatDomainError
  "math error"
rescue NameError => e
  "name error (#{e.class})"
rescue StandardError => e
  "other: #{e.class}"
end

puts classify { 1 / 0 }
puts classify { undefined_method_here }
puts classify { nil.size }
puts classify { raise "plain" }
puts classify { [].fetch(3) }
puts classify { 42 }
