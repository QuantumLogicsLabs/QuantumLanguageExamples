# A discrete Lotka-Volterra predator-prey model.
rabbits = 40.0
foxes = 9.0
a, b, c, d = 0.1, 0.02, 0.3, 0.01
dt = 0.1
history = []

(0..400).each do |step|
  history << [step * dt, rabbits, foxes] if (step % 40).zero?
  dr = (a * rabbits - b * rabbits * foxes) * dt
  df = (d * rabbits * foxes - c * foxes) * dt
  rabbits += dr
  foxes += df
end

history.each do |t, r, f|
  puts format("t=%5.1f rabbits %6.2f foxes %6.2f %s", t, r, f, "#" * (r / 4).round)
end
peak = history.max_by { |_, r, _| r }
puts "highest sampled rabbit population at t=#{peak[0]}"
