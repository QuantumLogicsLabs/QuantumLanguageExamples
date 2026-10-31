# Extracting and validating email addresses with regular expressions.
TEXT = <<~T
  Contact sales@example.com or support@help.example.org for help.
  Invalid ones: bob@, @nowhere.com, a@b, joe@@x.com.
  Mixed Case: Jane.Doe+news@Mail.Example.CO.UK and x_y-z@sub.domain.io!
T

EMAIL = /\b[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\.)+[A-Za-z]{2,}\b/

found = TEXT.scan(EMAIL)
puts found.inspect
normalized = found.map(&:downcase).uniq
puts normalized.inspect
by_domain = normalized.group_by { |e| e.split("@").last.split(".").last(2).join(".") }
puts by_domain.inspect
locals = normalized.map { |e| e.split("@").first }
puts locals.select { |l| l.include?("+") }.inspect
%w[ok@site.com no@site bad@-x.com a.b@c.de].each { |e| puts "#{e}: #{e.match?(/\A#{EMAIL}\z/)}" }
