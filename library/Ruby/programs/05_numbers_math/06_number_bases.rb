# Converting between bases.
n = 2024
puts n.to_s(2)
puts n.to_s(8)
puts n.to_s(16)
puts n.to_s(36)
puts "11111101000".to_i(2)
puts "7e8".to_i(16)
puts "zz".to_i(36)
puts 0b1010 + 0o17 + 0xff
puts "%08b" % 37
puts "%#x %#o" % [255, 255]
puts 255.digits(16).reverse.inspect
puts (1..16).map { |i| i.to_s(2).count("1") }.inspect
puts Integer("0x1f", 16) rescue puts Integer("1f", 16)
puts "ff".hex
puts "777".oct
