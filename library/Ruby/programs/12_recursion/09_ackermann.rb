# The Ackermann function and call counting.
$calls = 0

def ack(m, n)
  $calls += 1
  if m.zero? then n + 1
  elsif n.zero? then ack(m - 1, 1)
  else ack(m - 1, ack(m, n - 1))
  end
end

(0..3).each do |m|
  (0..4).each do |n|
    $calls = 0
    v = ack(m, n)
    print "A(#{m},#{n})=#{v} [#{$calls}]  "
  end
  puts
end
