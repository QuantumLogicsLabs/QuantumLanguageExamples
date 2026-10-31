# Counts ballots and runs an instant-runoff election.
ballots = [
  %w[ana ben cy], %w[ben ana cy], %w[cy ben ana], %w[ana cy ben], %w[ben cy ana],
  %w[cy ana ben], %w[ana ben cy], %w[ben ana cy], %w[cy ben ana]
]

first_choices = ballots.map(&:first).tally
puts "First choices: #{first_choices.sort.to_h.inspect}"

remaining = ballots.flatten.uniq.sort
round = 1
loop do
  tally = remaining.to_h { |c| [c, 0] }
  ballots.each do |b|
    choice = b.find { |c| remaining.include?(c) }
    tally[choice] += 1
  end
  puts "Round #{round}: #{tally.inspect}"
  leader, votes = tally.max_by { |c, v| [v, c] }
  if votes * 2 > ballots.size
    puts "Winner: #{leader} with #{votes} votes"
    break
  end
  loser = tally.min_by { |c, v| [v, c] }.first
  puts "Eliminated: #{loser}"
  remaining.delete(loser)
  round += 1
end
