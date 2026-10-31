# A discrete-event simulation of a bank with tellers.
Customer = Struct.new(:id, :arrives, :service)

ARRIVALS = [[0, 4], [1, 3], [2, 6], [3, 2], [5, 5], [6, 1], [8, 4], [9, 3], [10, 2], [14, 3]].freeze

def simulate(tellers)
  customers = ARRIVALS.each_with_index.map { |(a, s), i| Customer.new(i + 1, a, s) }
  free_at = Array.new(tellers, 0)
  waits = customers.map do |c|
    t = free_at.index(free_at.min)
    start = [free_at[t], c.arrives].max
    free_at[t] = start + c.service
    start - c.arrives
  end
  [waits, free_at.max]
end

(1..3).each do |n|
  waits, finish = simulate(n)
  puts "#{n} teller(s): avg wait #{(waits.sum.to_f / waits.size).round(2)}, max wait #{waits.max}, done at t=#{finish}"
end
