# strip, squeeze, delete, chomp and friends.
raw = "   Hello,    World!   \n"
puts raw.inspect
puts raw.strip.inspect
puts raw.lstrip.inspect
puts raw.rstrip.inspect
puts raw.chomp.inspect
puts raw.squeeze(" ").inspect
puts raw.strip.squeeze(" ")
puts "hello".delete("l")
puts "mississippi".squeeze
puts "mississippi".count("s")
puts "mississippi".chop
puts "".empty?
puts "  ".strip.empty?
puts "Tab\tseparated".tr("\t", " ")
puts "file.tar.gz".delete_suffix(".gz")
puts "Mr. Smith".delete_prefix("Mr. ")
