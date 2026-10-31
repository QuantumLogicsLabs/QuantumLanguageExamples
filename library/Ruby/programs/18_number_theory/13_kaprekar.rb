# Kaprekar's routine converging to 6174.
def kaprekar_step(n)
  digits = n.to_s.rjust(4, "0").chars.sort
  digits.reverse.join.to_i - digits.join.to_i
end

def routine(n)
  steps = [n]
  steps << kaprekar_step(steps.last) until steps.last == 6174 || steps.last.zero? || steps.size > 10
  steps
end

[3524, 2111, 9831, 1000, 6174, 1111].each { |n| puts routine(n).join(" -> ") }
counts = (1000..9999).reject { |n| n.to_s.chars.uniq.size == 1 }.map { |n| routine(n).size - 1 }.tally.sort
puts "iterations needed: #{counts.inspect}"
