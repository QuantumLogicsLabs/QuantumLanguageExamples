# Checking brackets with a stack.
PAIRS = { ")" => "(", "]" => "[", "}" => "{" }.freeze

def check(text)
  stack = []
  text.each_char.with_index do |ch, i|
    if PAIRS.value?(ch)
      stack.push([ch, i])
    elsif PAIRS.key?(ch)
      return "unexpected #{ch} at #{i}" if stack.empty?
      open, pos = stack.pop
      return "#{ch} at #{i} does not match #{open} at #{pos}" unless PAIRS[ch] == open
    end
  end
  stack.empty? ? "balanced" : "unclosed #{stack.last[0]} at #{stack.last[1]}"
end

["(a[b]{c})", "([)]", "((())", "{[()()]}", "a)b", "", "def f(x) { return [x * (x + 1)] }"].each do |t|
  puts "#{t.inspect.ljust(36)} #{check(t)}"
end
