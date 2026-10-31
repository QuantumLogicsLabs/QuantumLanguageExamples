# Symbols versus strings.
status = :active
puts status
puts status.inspect
puts status.to_s.upcase
puts "active".to_sym == status
puts :a.object_id == :a.object_id
puts "a".equal?("a")

colors = %i[red green blue]
puts colors.inspect
puts colors.map(&:to_s).map(&:capitalize).join(", ")

settings = { theme: :dark, font_size: 14, beta: false }
settings.each { |key, value| puts "#{key} (#{key.class}) => #{value.inspect}" }
puts settings.key?(:theme)
puts settings.keys.sort.inspect
puts :zebra <=> :apple
puts %i[pear apple fig].sort.inspect
