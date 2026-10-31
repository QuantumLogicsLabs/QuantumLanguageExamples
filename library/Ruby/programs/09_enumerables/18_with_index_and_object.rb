# with_index offsets and with_object.
fruits = %w[apple banana cherry]
fruits.each.with_index(1) { |f, i| puts "#{i}. #{f}" }
puts fruits.map.with_index(10) { |f, i| "#{i}-#{f[0]}" }.inspect
puts fruits.each_with_index.to_a.inspect
puts fruits.each.with_object([]) { |f, acc| acc.unshift(f) }.inspect
puts fruits.select.with_index { |_, i| i.odd? }.inspect
puts fruits.each_with_index.max_by { |f, _| f.length }.inspect
lookup = fruits.each_with_index.to_h
puts lookup.inspect
puts lookup.invert[2]
puts (1..6).each_slice(2).with_index.map { |pair, i| pair.sum * i }.inspect
