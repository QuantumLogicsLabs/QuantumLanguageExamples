# Inventory over 20 days with a reorder point and lead time.
demand = [4, 6, 3, 8, 5, 7, 2, 9, 6, 4, 5, 8, 7, 3, 6, 5, 9, 4, 6, 7]
stock = 20
reorder_point = 12
order_qty = 25
lead_time = 3
arrivals = {}
stockouts = 0
orders = 0

demand.each_with_index do |d, day|
  stock += arrivals.delete(day) || 0
  sold = [d, stock].min
  stockouts += d - sold
  stock -= sold
  if stock <= reorder_point && arrivals.empty?
    arrivals[day + lead_time] = order_qty
    orders += 1
    note = " -> order #{order_qty} due day #{day + lead_time}"
  end
  puts format("day %2d demand %d sold %d stock %2d%s", day, d, sold, stock, note)
  note = nil
end
puts "orders placed: #{orders}, units short: #{stockouts}"
