# Parsing a tiny SQL-like query language and running it.
ROWS = [
  { name: "ana", age: 34, city: "lima" }, { name: "ben", age: 25, city: "oslo" },
  { name: "cy", age: 41, city: "lima" }, { name: "dee", age: 29, city: "rome" },
  { name: "eli", age: 52, city: "oslo" }
].freeze

QUERY = /\ASELECT (?<fields>[\w, *]+) WHERE (?<field>\w+) (?<op>=|>|<|!=) (?<value>\w+)(?: ORDER BY (?<order>\w+)(?<desc> DESC)?)?\z/i

def run(q)
  m = QUERY.match(q) or return "syntax error: #{q}"
  fields = m[:fields] == "*" ? nil : m[:fields].split(",").map { |f| f.strip.to_sym }
  value = m[:value].match?(/\A\d+\z/) ? m[:value].to_i : m[:value]
  rows = ROWS.select do |r|
    v = r[m[:field].to_sym]
    case m[:op]
    when "=" then v == value
    when "!=" then v != value
    when ">" then v > value
    when "<" then v < value
    end
  end
  if m[:order]
    rows = rows.sort_by { |r| r[m[:order].to_sym] }
    rows = rows.reverse if m[:desc]
  end
  rows.map { |r| fields ? r.slice(*fields) : r }
end

["SELECT name WHERE city = lima", "SELECT name, age WHERE age > 28 ORDER BY age DESC",
 "SELECT * WHERE city != oslo ORDER BY name", "SELECT name WHERE age < 20", "DROP TABLE rows"].each do |q|
  puts q
  puts "  #{run(q).inspect}"
end
