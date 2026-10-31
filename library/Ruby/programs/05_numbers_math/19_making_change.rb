# Greedy change making in coins and notes.
DENOMINATIONS = [5000, 2000, 1000, 500, 200, 100, 50, 20, 10, 5, 1].freeze

def change(cents)
  DENOMINATIONS.each_with_object({}) do |d, out|
    count, cents = cents.divmod(d)
    out[d] = count if count.positive?
  end
end

def label(cents) = cents >= 100 ? "$#{cents / 100}" : "#{cents}c"

[[2000, 1263], [5000, 1], [10000, 3333]].each do |paid, price|
  due = paid - price
  parts = change(due).map { |d, n| "#{n} x #{label(d)}" }
  puts "Paid #{label(paid)} for #{price}c: change #{due}c = #{parts.join(', ')}"
end

counts = (1..99).map { |c| change(c).values.sum }
puts "Most coins needed for an amount under $1: #{counts.max} (for #{counts.index(counts.max) + 1}c)"
