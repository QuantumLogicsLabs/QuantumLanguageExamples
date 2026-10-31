# Lookahead and lookbehind assertions.
def strong?(pw) = pw.match?(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).{8,}\z/)

%w[password Passw0rd Passw0rd! short1A! ALLUPPER9! xX9!xxxx].each { |pw| puts "#{pw.ljust(12)} #{strong?(pw)}" }

prices = "USD100 EUR250 USD75 GBP30 USD5"
puts prices.scan(/(?<=USD)\d+/).inspect
puts prices.scan(/\d+(?= )/).inspect
puts prices.gsub(/(?<!USD)\b(\d+)/) { "[#{$1}]" }
puts "1234567890".gsub(/(\d)(?=(\d{3})+\z)/, '\1,')
puts "foobar foobaz fooqux".scan(/foo(?!bar)\w+/).inspect
puts "aaa bbb ccc".gsub(/\b(?=\w)/, "^")
