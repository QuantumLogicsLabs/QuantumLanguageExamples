# Scoring password strength with regular expressions.
RULES = [
  [/.{12,}/, 2, "12+ characters"],
  [/.{8,}/, 1, "8+ characters"],
  [/[a-z]/, 1, "lowercase"],
  [/[A-Z]/, 1, "uppercase"],
  [/\d/, 1, "digit"],
  [/[^A-Za-z0-9]/, 2, "symbol"]
].freeze
PENALTIES = [
  [/(.)\1\1/, 2, "repeated characters"],
  [/(?:abc|123|qwerty|password)/i, 3, "common sequence"],
  [/\A\d+\z/, 2, "digits only"]
].freeze

def score(pw)
  points = RULES.sum { |re, pts, _| pw.match?(re) ? pts : 0 }
  issues = PENALTIES.select { |re, _, _| pw.match?(re) }
  points -= issues.sum { |_, pts, _| pts }
  [points.clamp(0, 10), issues.map(&:last)]
end

def label(s) = %w[terrible weak weak fair fair good good strong strong excellent excellent][s]

["password", "12345678", "Tr0ub4dor&3", "correct horse battery staple", "aaaBBB111!!!", "Xk#9vQ!m2Lp@"].each do |pw|
  s, issues = score(pw)
  puts "#{pw.ljust(30)} #{s.to_s.rjust(2)} #{label(s).ljust(9)} #{issues.empty? ? '' : "(#{issues.join(', ')})"}"
end
