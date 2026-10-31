# A ball dropped with gravity and energy loss on each bounce.
g = -9.81
dt = 0.01
height = 10.0
velocity = 0.0
restitution = 0.7
time = 0.0
bounces = []
max_heights = [height]
rising = false

while bounces.size < 5
  velocity += g * dt
  height += velocity * dt
  time += dt
  if height <= 0
    height = 0.0
    velocity = -velocity * restitution
    bounces << time.round(2)
    rising = true
  elsif rising && velocity <= 0
    max_heights << height.round(3)
    rising = false
  end
end

puts "bounce times: #{bounces.inspect}"
puts "peak heights: #{max_heights.inspect}"
ratios = max_heights.each_cons(2).map { |x, y| (y / x).round(3) }
puts "height ratios: #{ratios.inspect} (restitution^2 = #{restitution**2})"
