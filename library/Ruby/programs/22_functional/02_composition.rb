# Building pipelines from small functions.
strip = ->(s) { s.strip }
downcase = :downcase.to_proc
squeeze_spaces = ->(s) { s.gsub(/\s+/, " ") }
remove_punct = ->(s) { s.delete("^a-z0-9 ") }
words = ->(s) { s.split }
count = ->(xs) { xs.tally }
top3 = ->(h) { h.sort_by { |w, n| [-n, w] }.first(3) }

normalize = strip >> downcase >> squeeze_spaces >> remove_punct
analyze = normalize >> words >> count >> top3

text = "  The cat and the hat.   The CAT sat!  And the bat?  "
puts normalize.(text).inspect
puts analyze.(text).inspect

compose = ->(*fns) { fns.reduce(:>>) }
inc = ->(x) { x + 1 }
dbl = ->(x) { x * 2 }
puts compose.(inc, dbl, inc).(5)
puts (inc << dbl).(5)
puts [1, 2, 3].map(&(dbl >> inc)).inspect
