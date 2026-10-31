# Letter grades from numeric scores, with a class summary.
def letter(score)
  if score >= 90
    "A"
  elsif score >= 80
    "B"
  elsif score >= 70
    "C"
  elsif score >= 60
    "D"
  else
    "F"
  end
end

scores = { "Alice" => 93, "Bob" => 78, "Chen" => 85, "Dara" => 59, "Eve" => 70 }
scores.each do |student, score|
  puts "#{student.ljust(6)} #{score.to_s.rjust(3)}  #{letter(score)}"
end

total = scores.values.sum
average = total.to_f / scores.size
puts "Average: #{average.round(2)} (#{letter(average)})"
best = scores.max_by { |_, s| s }
puts "Top student: #{best[0]} with #{best[1]}"
passed = scores.count { |_, s| s >= 60 }
puts "#{passed} of #{scores.size} passed"
