# A round-robin tournament schedule and results table.
teams = %w[Lions Tigers Bears Wolves Eagles Sharks]

def schedule(teams)
  list = teams.dup
  list << "BYE" if list.size.odd?
  n = list.size
  (n - 1).times.map do |round|
    pairs = (0...n / 2).map { |i| [list[i], list[n - 1 - i]] }
    list = [list[0]] + [list[-1]] + list[1...-1]
    round.odd? ? pairs.map(&:reverse) : pairs
  end
end

rounds = schedule(teams)
rounds.each_with_index { |r, i| puts "Round #{i + 1}: #{r.map { |a, b| "#{a}-#{b}" }.join(', ')}" }

points = Hash.new(0)
rounds.flatten(1).each_with_index do |(home, away), k|
  goals_home = (home.size * 3 + k) % 4
  goals_away = (away.size * 2 + k) % 3
  if goals_home > goals_away then points[home] += 3
  elsif goals_home < goals_away then points[away] += 3
  else
    points[home] += 1
    points[away] += 1
  end
end
points.sort_by { |t, p| [-p, t] }.each_with_index { |(t, p), i| puts "#{i + 1}. #{t.ljust(7)} #{p}" }
