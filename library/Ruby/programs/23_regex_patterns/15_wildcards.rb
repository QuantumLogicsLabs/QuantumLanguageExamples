# Glob-style wildcard matching: by regex and by dynamic programming.
def glob_to_regex(pattern)
  body = pattern.chars.map do |c|
    case c
    when "*" then ".*"
    when "?" then "."
    else Regexp.escape(c)
    end
  end.join
  /\A#{body}\z/
end

def glob_dp(text, pat)
  dp = Array.new(text.size + 1) { Array.new(pat.size + 1, false) }
  dp[0][0] = true
  (1..pat.size).each { |j| dp[0][j] = dp[0][j - 1] && pat[j - 1] == "*" }
  (1..text.size).each do |i|
    (1..pat.size).each do |j|
      dp[i][j] = if pat[j - 1] == "*"
                   dp[i - 1][j] || dp[i][j - 1]
                 else
                   dp[i - 1][j - 1] && (pat[j - 1] == "?" || pat[j - 1] == text[i - 1])
                 end
    end
  end
  dp[text.size][pat.size]
end

files = %w[main.rb test_main.rb README.md app.js lib.rb notes.txt data_2024.csv data_23.csv]
["*.rb", "test_*", "data_????.csv", "*.*s", "?a*"].each do |pat|
  by_regex = files.select { |f| f.match?(glob_to_regex(pat)) }
  by_dp = files.select { |f| glob_dp(f, pat) }
  puts "#{pat.ljust(14)} #{by_regex.inspect} #{by_regex == by_dp ? 'agree' : 'DISAGREE'}"
end
