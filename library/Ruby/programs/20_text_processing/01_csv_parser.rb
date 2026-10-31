# A small CSV parser that handles quoted fields.
def parse_line(line)
  fields = []
  field = +""
  quoted = false
  i = 0
  while i < line.size
    c = line[i]
    if quoted
      if c == '"' && line[i + 1] == '"'
        field << '"'
        i += 1
      elsif c == '"'
        quoted = false
      else
        field << c
      end
    elsif c == '"'
      quoted = true
    elsif c == ","
      fields << field
      field = +""
    else
      field << c
    end
    i += 1
  end
  fields << field
end

data = <<~CSV
  name,city,quote,amount
  Ana,"Lima, Peru","She said ""hi""",12.50
  Ben,Oslo,,7
  "Cy, Jr.",Rome,"multi, comma, field",100.25
CSV

header, *rows = data.lines.map { |l| parse_line(l.chomp) }
records = rows.map { |r| header.zip(r).to_h }
records.each { |r| puts r.inspect }
puts "total: #{records.sum { |r| r['amount'].to_f }}"
puts "cities: #{records.map { |r| r['city'] }.join(' | ')}"
