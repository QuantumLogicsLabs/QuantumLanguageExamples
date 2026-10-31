# Triggering and identifying the common built-in errors.
cases = {
  "nil method" => -> { nil.upcase },
  "string plus int" => -> { "a" + 1 },
  "missing key" => -> { { a: 1 }.fetch(:b) },
  "bad index" => -> { [1].fetch(5) },
  "bad integer" => -> { Integer("12abc") },
  "divide by zero" => -> { 5 / 0 },
  "frozen" => -> { "x".freeze << "y" },
  "undefined name" => -> { totally_undefined },
  "wrong arity" => -> { ->(a) { a }.call },
  "range" => -> { [1, 2].first(-1) }
}

cases.each do |label, job|
  job.call
  puts "#{label}: no error"
rescue => e
  puts "#{label.ljust(16)} #{e.class}"
end
