# Tokenizing with StringScanner.
require "strscan"

def tokens(src)
  ss = StringScanner.new(src)
  out = []
  until ss.eos?
    if ss.skip(/\s+/) then next
    elsif (t = ss.scan(/\d+\.\d+|\d+/)) then out << [:num, t.include?(".") ? t.to_f : t.to_i]
    elsif (t = ss.scan(/[a-zA-Z_]\w*/)) then out << [:id, t]
    elsif (t = ss.scan(/"(?:[^"\\]|\\.)*"/)) then out << [:str, t[1...-1]]
    elsif (t = ss.scan(/==|!=|<=|>=|[-+*\/=<>()]/)) then out << [:op, t]
    else raise "bad input at #{ss.pos}: #{ss.peek(5).inspect}"
    end
  end
  out
end

p tokens('x = 3.14 * (radius + 2)')
p tokens('name == "Bob \"the\" builder"')
begin
  tokens("a = 5 $ 2")
rescue RuntimeError => e
  puts e.message
end
ss = StringScanner.new("key1=val1;key2=val2")
pairs = {}
until ss.eos?
  key = ss.scan(/\w+/)
  ss.skip(/=/)
  pairs[key] = ss.scan(/\w+/)
  ss.skip(/;/)
end
puts pairs.inspect
