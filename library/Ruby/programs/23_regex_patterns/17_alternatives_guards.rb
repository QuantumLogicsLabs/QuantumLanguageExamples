# Alternative patterns, guards and binding.
def classify(x)
  case x
  in Integer | Float => n if n.negative? then "negative number #{n}"
  in 0 | 0.0 then "zero"
  in Integer => n if n.even? then "even #{n}"
  in Integer => n then "odd #{n}"
  in Float => f then "float #{f}"
  in "" | [] | {} then "empty #{x.class}"
  in String => s if s.match?(/\A\d+\z/) then "numeric string #{s}"
  in String | Symbol => s then "text #{s}"
  in nil then "nil"
  in [Integer, *] | [Float, *] => list then "numeric list of #{list.size}"
  else "other #{x.class}"
  end
end

[-3, 0, 8, 7, 2.5, -0.5, "", [], {}, "42", "hi", :sym, nil, [1, 2], [1.5], [:a], true].each do |v|
  puts "#{v.inspect.ljust(6)} #{classify(v)}"
end
