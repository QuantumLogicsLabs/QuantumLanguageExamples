# Processing a batch and summarising the failures.
records = ["id=1;qty=4;price=2.5", "id=2;qty=x;price=1.0", "id=3;qty=2", "id=4;qty=1;price=-3",
           "garbage", "id=6;qty=10;price=0.99"]

Failure = Struct.new(:line, :reason)
totals = []
failures = []

records.each_with_index do |rec, i|
  fields = rec.split(";").to_h { |pair| pair.split("=", 2) }
  qty = Integer(fields.fetch("qty"))
  price = Float(fields.fetch("price"))
  raise ArgumentError, "negative price" if price.negative?
  totals << (qty * price).round(2)
rescue KeyError => e
  failures << Failure.new(i + 1, "missing field #{e.key}")
rescue ArgumentError, TypeError => e
  failures << Failure.new(i + 1, e.message[0, 40])
end

puts "Processed #{totals.size} of #{records.size}, total #{totals.sum.round(2)}"
failures.each { |f| puts "  line #{f.line}: #{f.reason}" }
puts "Failure kinds: #{failures.group_by { |f| f.reason.split.first }.keys.inspect}"
