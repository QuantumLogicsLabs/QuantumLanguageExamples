# Rod cutting for maximum revenue.
PRICES = [0, 1, 5, 8, 9, 10, 17, 17, 20, 24, 30].freeze

def cut_rod(n)
  revenue = Array.new(n + 1, 0)
  first_cut = Array.new(n + 1, 0)
  (1..n).each do |len|
    (1..[len, PRICES.size - 1].min).each do |cut|
      candidate = PRICES[cut] + revenue[len - cut]
      if candidate > revenue[len]
        revenue[len] = candidate
        first_cut[len] = cut
      end
    end
  end
  pieces = []
  len = n
  while len.positive?
    pieces << first_cut[len]
    len -= first_cut[len]
  end
  [revenue[n], pieces]
end

(1..12).each do |n|
  best, pieces = cut_rod(n)
  puts "length #{n.to_s.rjust(2)}: revenue #{best.to_s.rjust(2)} pieces #{pieces.inspect}"
end
