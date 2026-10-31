# The Josephus problem: simulation and closed form.
def simulate(n, k)
  people = (1..n).to_a
  idx = 0
  order = []
  until people.size == 1
    idx = (idx + k - 1) % people.size
    order << people.delete_at(idx)
  end
  [people.first, order]
end

def josephus(n, k) = (1..n).reduce(0) { |pos, m| (pos + k) % m } + 1

survivor, order = simulate(7, 3)
puts "n=7, k=3: elimination order #{order.inspect}, survivor #{survivor}"
[[10, 2], [41, 3], [100, 7], [1, 5]].each do |n, k|
  puts "n=#{n}, k=#{k}: survivor #{simulate(n, k).first} (formula #{josephus(n, k)})"
end
puts "k=2 survivors for n=1..16: #{(1..16).map { |n| josephus(n, 2) }.inspect}"
