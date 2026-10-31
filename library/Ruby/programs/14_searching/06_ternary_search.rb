# Ternary search for the maximum of a unimodal function.
def ternary_max(lo, hi, iterations = 100)
  iterations.times do
    m1 = lo + (hi - lo) / 3
    m2 = hi - (hi - lo) / 3
    yield(m1) < yield(m2) ? lo = m1 : hi = m2
  end
  (lo + hi) / 2
end

f = ->(x) { -(x - 2.5)**2 + 7 }
x = ternary_max(0.0, 10.0) { |v| f.(v) }
puts "max of -(x-2.5)^2+7 at x=#{x.round(6)}, value #{f.(x).round(6)}"

g = ->(x) { Math.sin(x) }
x2 = ternary_max(0.0, Math::PI) { |v| g.(v) }
puts "max of sin on [0, pi] at #{x2.round(6)} (pi/2 = #{(Math::PI / 2).round(6)})"

area = ->(w) { w * (20 - 2 * w) * (20 - 2 * w) }
best = ternary_max(0.0, 10.0) { |w| area.(w) }
puts "Open box from a 20x20 sheet: cut #{best.round(4)}, volume #{area.(best).round(3)}"
