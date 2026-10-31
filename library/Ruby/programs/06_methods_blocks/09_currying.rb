# Currying and partial application.
volume = ->(l, w, h) { l * w * h }
curried = volume.curry
puts curried[2][3][4]
base_2x3 = curried[2][3]
puts [1, 5, 10].map { |h| base_2x3[h] }.inspect

power = ->(exp, base) { base**exp }.curry
square = power[2]
cube = power[3]
puts (1..5).map(&square).inspect
puts (1..5).map(&cube).inspect

def log_message(level, component, message) = "[#{level}] #{component}: #{message}"
log = method(:log_message).curry
warn_db = log["WARN"]["db"]
puts warn_db["slow query"]
puts log["INFO"]["web"]["started"]

add3 = proc { |a, b, c| (a || 0) + (b || 0) + (c || 0) }
puts add3.curry(3)[1][2][3]
