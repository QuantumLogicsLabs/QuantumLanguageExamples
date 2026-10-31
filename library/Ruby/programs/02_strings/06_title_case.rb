# Title case that keeps small words lower case (except at the start).
SMALL = %w[a an and as at but by for in of on or the to with].freeze

def title_case(text)
  text.split.each_with_index.map do |word, i|
    lower = word.downcase
    if i.positive? && SMALL.include?(lower)
      lower
    else
      lower.capitalize
    end
  end.join(" ")
end

titles = [
  "the lord of the rings",
  "a tale of two cities",
  "WAR AND PEACE",
  "of mice and men",
  "to kill a mockingbird"
]
titles.each { |t| puts "#{t.ljust(24)} -> #{title_case(t)}" }
