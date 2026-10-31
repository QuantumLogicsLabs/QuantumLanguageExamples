# A gradebook as a hash of hashes.
grades = {
  "Ana" => { math: 91, physics: 84, history: 77 },
  "Ben" => { math: 68, physics: 72, history: 95 },
  "Cyd" => { math: 85, physics: 90, history: 88 },
  "Dee" => { math: 79, physics: 65, history: 70 }
}

averages = grades.transform_values { |subjects| (subjects.values.sum / subjects.size.to_f).round(2) }
averages.sort_by { |_, avg| -avg }.each { |name, avg| puts "#{name}: #{avg}" }

subjects = grades.values.first.keys
subjects.each do |subject|
  scores = grades.transform_values { |s| s[subject] }
  best = scores.max_by { |_, v| v }
  mean = scores.values.sum / scores.size.to_f
  puts "#{subject.to_s.ljust(8)} mean #{mean.round(1).to_s.rjust(5)}, best #{best[0]} (#{best[1]})"
end

honours = grades.select { |_, s| s.values.all? { |v| v >= 75 } }.keys
puts "Honour roll: #{honours.inspect}"
