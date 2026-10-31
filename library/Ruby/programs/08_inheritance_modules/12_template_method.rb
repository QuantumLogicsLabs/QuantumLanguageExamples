# The template method pattern with hooks.
class Report
  def generate
    [header, *body_lines, footer].compact.join("\n")
  end

  def header = "== #{title} =="
  def footer = nil
  def body_lines = rows.map { |r| format_row(r) }
  def format_row(row) = row.join(", ")
end

class SalesReport < Report
  def title = "Sales"
  def rows = [["north", 120], ["south", 80]]
  def format_row(row) = "#{row[0].ljust(6)} #{row[1].to_s.rjust(5)}"
  def footer = "total #{rows.sum(&:last)}"
end

class InventoryReport < Report
  def title = "Inventory"
  def rows = [["bolts", 300, "ok"], ["gears", 4, "low"]]
end

puts SalesReport.new.generate
puts
puts InventoryReport.new.generate
