# A small warehouse inventory.
inventory = { "bolts" => 120, "nuts" => 80, "screws" => 15, "washers" => 0 }
deliveries = [["nuts", 40], ["washers", 200], ["hinges", 25]]
orders = [["bolts", 30], ["screws", 20], ["nuts", 60]]

deliveries.each { |item, qty| inventory[item] = inventory.fetch(item, 0) + qty }
orders.each do |item, qty|
  if inventory.fetch(item, 0) >= qty
    inventory[item] -= qty
    puts "Shipped #{qty} #{item}"
  else
    puts "Cannot ship #{qty} #{item}: only #{inventory.fetch(item, 0)}"
  end
end

puts "Stock:"
inventory.sort.each { |item, qty| puts "  #{item.ljust(8)} #{qty.to_s.rjust(4)}" }
low = inventory.select { |_, q| q < 50 }.keys
puts "Reorder: #{low.join(', ')}"
puts "Total units: #{inventory.values.sum}"
