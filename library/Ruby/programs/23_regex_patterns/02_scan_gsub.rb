# Finding all matches and replacing with blocks.
text = "Prices: $5, $12.50, $1,200 and $0.99. Call 555-1234 or 555-9876."

prices = text.scan(/\$([\d,]+(?:\.\d+)?)/).flatten
puts prices.inspect
puts prices.sum { |p| p.delete(",").to_f }
puts text.scan(/\d{3}-\d{4}/).inspect
puts text.scan(/(\d{3})-(\d{4})/).map { |a, b| "#{b}-#{a}" }.inspect
puts text.gsub(/\$([\d,.]+)/) { "EUR #{(Regexp.last_match(1).delete(',').to_f * 0.9).round(2)}" }
puts text.gsub(/\d/, "#").squeeze("#")
puts "hello world".gsub(/o/, "o" => "0")
puts "snake_case_to_camel".gsub(/_([a-z])/) { $1.upcase }
puts "The Quick Brown".gsub(/(?<first>\w)(?<rest>\w*)/) { "#{$~[:rest]}#{$~[:first]}ay" }
puts "a1b22c333".scan(/[a-z]\d+/).map(&:length).inspect
