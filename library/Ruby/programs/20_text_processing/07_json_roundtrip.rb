# Generating and parsing JSON with the standard library.
require "json"

order = {
  id: 1042,
  customer: { name: "Ana", vip: true },
  items: [{ sku: "A-1", qty: 2, price: 9.99 }, { sku: "B-7", qty: 1, price: 24.5 }],
  notes: nil
}

compact = JSON.generate(order)
puts compact
puts JSON.pretty_generate(order)

parsed = JSON.parse(compact)
puts parsed["customer"]["name"]
puts parsed["items"].sum { |i| i["qty"] * i["price"] }.round(2)
puts parsed.keys.inspect
puts JSON.parse(compact, symbolize_names: true)[:items].first[:sku]
puts [1, "two", nil, true, 3.5].to_json
puts JSON.parse('{"a": [1, 2, {"b": null}]}').inspect
begin
  JSON.parse("{bad json}")
rescue JSON::ParserError
  puts "invalid JSON rejected"
end
