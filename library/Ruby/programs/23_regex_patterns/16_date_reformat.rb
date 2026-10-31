# Rewriting date formats with backreferences.
text = "Meetings: 2024-03-15, 2024-11-02 and 1999-12-31. Deadline 03/04/2025 (US)."

puts text.gsub(/(\d{4})-(\d{2})-(\d{2})/, '\3.\2.\1')
puts text.gsub(/(?<y>\d{4})-(?<m>\d{2})-(?<d>\d{2})/, '\k<d>/\k<m>/\k<y>')
MONTHS = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec].freeze
puts text.gsub(/(\d{4})-(\d{2})-(\d{2})/) { "#{$3.to_i} #{MONTHS[$2.to_i - 1]} #{$1}" }
puts text.gsub(%r{(\d{2})/(\d{2})/(\d{4})}) { "#{$3}-#{$1}-#{$2}" }
years = text.scan(/\b(?:19|20)\d{2}\b/)
puts years.inspect
puts years.map(&:to_i).minmax.inspect
