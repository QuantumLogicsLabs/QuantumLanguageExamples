# Full justification of text to a fixed width.
def justify(words, width)
  lines = []
  current = []
  words.each do |w|
    if (current + [w]).join(" ").size > width
      lines << current
      current = [w]
    else
      current << w
    end
  end
  lines << current unless current.empty?
  lines.each_with_index.map do |line, i|
    if i == lines.size - 1 || line.size == 1
      line.join(" ").ljust(width)
    else
      gaps = line.size - 1
      spaces = width - line.sum(&:size)
      q, r = spaces.divmod(gaps)
      line.each_with_index.map { |w, k| k < gaps ? w + " " * (q + (k < r ? 1 : 0)) : w }.join
    end
  end
end

words = "This is an example of text justification where every line except the last is padded evenly".split
justify(words, 20).each { |l| puts "|#{l}|" }
puts
justify(%w[What must be acknowledgment shall be], 16).each { |l| puts "|#{l}|" }
