# A phone book with searches.
book = {
  "Alice Smith" => "555-0101",
  "Bob Jones" => "555-0199",
  "Alicia Keys" => "555-0142",
  "Carlos Diaz" => "555-0120",
  "Bea Smith" => "555-0175"
}

def search(book, term)
  book.select { |name, _| name.downcase.include?(term.downcase) }
end

%w[ali smith zed].each do |term|
  found = search(book, term)
  puts "#{term}: #{found.empty? ? 'no match' : found.keys.join(', ')}"
end

by_surname = book.keys.group_by { |n| n.split.last }
by_surname.sort.each { |surname, names| puts "#{surname}: #{names.sort.join(' & ')}" }
puts book.sort_by { |_, num| num }.first.inspect
puts book.reject { |n, _| n.start_with?("B") }.size
