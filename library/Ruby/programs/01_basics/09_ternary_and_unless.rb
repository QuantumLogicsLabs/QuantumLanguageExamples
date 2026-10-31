# Ternaries, unless and statement modifiers.
temperatures = [12, 25, 31, -3, 18]

temperatures.each do |t|
  feel = t > 28 ? "hot" : t > 15 ? "warm" : t > 0 ? "cool" : "freezing"
  puts "#{t}C feels #{feel}"
end

stock = { apples: 4, pears: 0, plums: 12 }
stock.each do |fruit, qty|
  puts "Order more #{fruit}" unless qty > 2
  puts "#{fruit} in stock: #{qty}" if qty > 0
end

balance = 50
withdrawal = 80
puts(balance >= withdrawal ? "Approved" : "Declined: short by #{withdrawal - balance}")

unless temperatures.empty?
  puts "Max #{temperatures.max}, min #{temperatures.min}"
else
  puts "No readings"
end
