# A tiny regex matcher supporting literals, ., *, ^ and $ (after Pike and Kernighan).
def match_here(re, text)
  return true if re.empty?
  return match_star(re[0], re[2..], text) if re[1] == "*"
  return text.empty? if re == "$"
  return match_here(re[1..], text[1..]) if !text.empty? && (re[0] == "." || re[0] == text[0])
  false
end

def match_star(c, re, text)
  loop do
    return true if match_here(re, text)
    return false if text.empty? || (c != "." && text[0] != c)
    text = text[1..]
  end
end

def tiny_match(re, text)
  return match_here(re[1..], text) if re.start_with?("^")
  (0..text.size).any? { |i| match_here(re, text[i..]) }
end

cases = [["abc", "xabcy"], ["^abc", "xabc"], ["a.c", "abc"], ["ab*c", "ac"], ["ab*c", "abbbbc"], ["^a.*z$", "abcz"],
         ["^a.*z$", "abczq"], ["colou*r", "color"], ["x*y", "zzz"], ["^$", ""]]
cases.each do |re, text|
  ours = tiny_match(re, text)
  ruby = text.match?(Regexp.new(re))
  puts "#{re.ljust(8)} #{text.inspect.ljust(9)} #{ours} #{ours == ruby ? '(agrees with Ruby)' : '(DIFFERS)'}"
end
