# A data pipeline over sales records.
raw = <<~CSV
  date,region,product,units,price
  2024-01-03,north,widget,10,2.50
  2024-01-03,south,gadget,4,10.00
  2024-01-04,north,gadget,2,10.00
  2024-01-05,east,widget,25,2.40
  2024-01-05,south,widget,8,2.50
  2024-01-06,north,gizmo,1,99.00
  2024-01-06,east,gadget,6,9.50
CSV

header, *lines = raw.lines.map(&:chomp)
keys = header.split(",").map(&:to_sym)
records = lines.map { |l| keys.zip(l.split(",")).to_h }
               .map { |r| r.merge(units: r[:units].to_i, price: r[:price].to_f) }
               .map { |r| r.merge(revenue: (r[:units] * r[:price]).round(2)) }

puts "Revenue by region:"
records.group_by { |r| r[:region] }
       .transform_values { |rs| rs.sum { |r| r[:revenue] }.round(2) }
       .sort_by { |_, v| -v }
       .each { |region, total| puts "  #{region.ljust(6)} #{format('%8.2f', total)}" }

puts "Units by product: #{records.each_with_object(Hash.new(0)) { |r, h| h[r[:product]] += r[:units] }.inspect}"
best_day = records.group_by { |r| r[:date] }.max_by { |_, rs| rs.sum { |r| r[:revenue] } }.first
puts "Best day: #{best_day}"
puts "Average price: #{(records.sum { |r| r[:price] } / records.size).round(3)}"
