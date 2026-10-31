# Heredocs with interpolation for a small report.
team = "Platform"
members = { "Ana" => 12, "Ben" => 7, "Cy" => 15 }
total = members.values.sum

report = <<~REPORT
  Team: #{team}
  Members: #{members.size}
  Tickets closed: #{total}
  Average per person: #{(total.to_f / members.size).round(1)}
REPORT
puts report

members.each do |name, n|
  puts <<~LINE.chomp
    - #{name}: #{n} tickets (#{(n * 100.0 / total).round}%)
  LINE
end

raw = <<~'RAW'
  No #{interpolation} here
RAW
puts raw
