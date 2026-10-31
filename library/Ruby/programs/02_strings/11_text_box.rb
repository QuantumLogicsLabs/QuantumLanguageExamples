# Draws text inside boxes with center, ljust and rjust.
def box(lines, align = :center)
  width = lines.map(&:length).max + 2
  out = ["+" + "-" * width + "+"]
  lines.each do |l|
    body = case align
           when :left then l.ljust(width - 2)
           when :right then l.rjust(width - 2)
           else l.center(width - 2)
           end
    out << "| #{body} |"
  end
  out << "+" + "-" * width + "+"
  out.join("\n")
end

menu = ["Menu", "Soup", "Steak and chips", "Ice cream"]
puts box(menu)
puts box(menu, :left)
puts box(menu, :right)
puts "*".center(11, "-")
