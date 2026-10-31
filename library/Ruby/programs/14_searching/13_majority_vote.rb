# Boyer-Moore majority vote.
def majority(a)
  candidate, count = nil, 0
  a.each do |x|
    if count.zero?
      candidate = x
      count = 1
    elsif x == candidate
      count += 1
    else
      count -= 1
    end
  end
  a.count(candidate) > a.size / 2 ? candidate : nil
end

def over_third(a)
  a.tally.select { |_, n| n > a.size / 3 }.keys.sort
end

[[2, 2, 1, 1, 1, 2, 2], [3, 3, 4], [1, 2, 3, 4], %w[a b a c a a]].each do |a|
  puts "#{a.inspect}: majority #{majority(a).inspect}, >1/3 #{over_third(a).inspect}"
end
