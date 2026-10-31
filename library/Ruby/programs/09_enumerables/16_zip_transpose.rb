# Rows, columns and unzipping.
rows = [["name", "age", "city"], ["Ana", 31, "Lima"], ["Ben", 25, "Oslo"], ["Cy", 40, "Rome"]]
columns = rows.transpose
columns.each { |col| puts "#{col.first}: #{col.drop(1).inspect}" }

header, *records = rows
hashes = records.map { |r| header.zip(r).to_h }
puts hashes.inspect

names, ages = records.map { |n, a, _| [n, a] }.transpose
puts names.inspect
puts ages.sum

widths = columns.map { |c| c.map { |v| v.to_s.length }.max }
rows.each { |r| puts r.zip(widths).map { |v, w| v.to_s.ljust(w) }.join(" | ") }
