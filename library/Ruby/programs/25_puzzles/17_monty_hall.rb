# The Monty Hall problem by exact enumeration.
outcomes = Hash.new(0)
total = 0
(1..3).each do |car|
  (1..3).each do |pick|
    hosts = (1..3).to_a - [car, pick]
    hosts.each do |opened|
      weight = Rational(1, 9) / hosts.size
      switch_to = ((1..3).to_a - [pick, opened]).first
      outcomes[:stay] += weight if pick == car
      outcomes[:switch] += weight if switch_to == car
      total += 1
    end
  end
end
puts "enumerated #{total} host choices"
puts "P(win | stay) = #{outcomes[:stay]}"
puts "P(win | switch) = #{outcomes[:switch]}"

doors = 10
stay = Rational(1, doors)
puts "with #{doors} doors and the host opening all but one: stay #{stay}, switch #{1 - stay}"
