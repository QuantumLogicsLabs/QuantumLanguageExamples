# Greedy versus lazy quantifiers.
html = '<b>bold</b> and <i>italic</i> text'
puts html[/<.+>/]
puts html[/<.+?>/]
puts html.scan(/<(\w+)>(.*?)<\/\1>/).inspect
puts html.gsub(/<[^>]+>/, "")
puts "aaaa"[/a{2,3}/]
puts "aaaa"[/a{2,3}?/]
puts "xyz123abc456"[/\d+/]
puts "xyz123abc456"[/.*\d/]
puts "xyz123abc456"[/.*?\d/]
puts '"one" and "two"'.scan(/"(.*?)"/).flatten.inspect
puts '"one" and "two"'.scan(/"(.*)"/).flatten.inspect
puts "a,b,,c".split(/,+/).inspect
puts "<<nested>>"[/<+(.*?)>+/, 1]
