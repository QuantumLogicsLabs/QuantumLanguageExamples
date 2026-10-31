# The SIR epidemic model with daily steps.
population = 10_000.0
infected = 10.0
recovered = 0.0
susceptible = population - infected
beta = 0.3
gamma = 0.1

peak_day, peak = 0, infected
(1..160).each do |day|
  new_infections = beta * susceptible * infected / population
  new_recoveries = gamma * infected
  susceptible -= new_infections
  infected += new_infections - new_recoveries
  recovered += new_recoveries
  peak_day, peak = day, infected if infected > peak
  next unless (day % 20).zero?
  puts format("day %3d  S %7.0f  I %7.0f  R %7.0f  %s", day, susceptible, infected, recovered, "*" * (infected / 200).round)
end
puts "R0 = #{(beta / gamma).round(2)}, peak of #{peak.round} infected on day #{peak_day}"
puts "never infected: #{(susceptible / population * 100).round(1)}%"
