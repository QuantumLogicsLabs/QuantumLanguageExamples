# Recursive generation of Gray codes and binary strings.
def gray(n)
  return [""] if n.zero?
  prev = gray(n - 1)
  prev.map { |c| "0" + c } + prev.reverse.map { |c| "1" + c }
end

def binary_strings(n, no_consecutive_ones: false)
  return [""] if n.zero?
  binary_strings(n - 1, no_consecutive_ones: no_consecutive_ones).flat_map do |s|
    ["0", "1"].filter_map { |b| s + b unless no_consecutive_ones && b == "1" && s.end_with?("1") }
  end
end

g = gray(4)
puts g.join(" ")
puts g.each_cons(2).all? { |a, b| a.chars.zip(b.chars).count { |x, y| x != y } == 1 }
puts binary_strings(3).inspect
puts (1..10).map { |n| binary_strings(n, no_consecutive_ones: true).size }.inspect
