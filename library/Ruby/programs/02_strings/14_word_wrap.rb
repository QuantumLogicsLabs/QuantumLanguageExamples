# Greedy word wrapping to a fixed width.
def wrap(text, width)
  lines = []
  current = +""
  text.split.each do |word|
    if current.empty?
      current << word
    elsif current.length + 1 + word.length <= width
      current << " " << word
    else
      lines << current
      current = word.dup
    end
  end
  lines << current unless current.empty?
  lines
end

text = "Ruby is a dynamic, open source programming language with a focus on " \
       "simplicity and productivity. It has an elegant syntax that is natural " \
       "to read and easy to write."

[20, 32].each do |width|
  puts "Width #{width}:"
  wrap(text, width).each { |l| puts "|#{l.ljust(width)}|" }
end
