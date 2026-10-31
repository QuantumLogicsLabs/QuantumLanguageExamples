# Comparing algorithms by the number of comparisons they make.
class Counter
  attr_reader :count
  def initialize = @count = 0
  def less?(a, b)
    @count += 1
    a < b
  end
end

def insertion(a, c)
  a = a.dup
  (1...a.size).each do |i|
    j = i
    while j.positive? && c.less?(a[j], a[j - 1])
      a[j], a[j - 1] = a[j - 1], a[j]
      j -= 1
    end
  end
  a
end

def merge_sort(a, c)
  return a if a.size < 2
  l = merge_sort(a[0...a.size / 2], c)
  r = merge_sort(a[a.size / 2..], c)
  out = []
  out << (c.less?(r.first, l.first) ? r.shift : l.shift) until l.empty? || r.empty?
  out + l + r
end

def selection(a, c)
  a = a.dup
  (0...a.size).each do |i|
    m = i
    (i + 1...a.size).each { |j| m = j if c.less?(a[j], a[m]) }
    a[i], a[m] = a[m], a[i]
  end
  a
end

inputs = {
  "sorted" => (1..32).to_a,
  "reversed" => (1..32).to_a.reverse,
  "zigzag" => (1..32).map { |i| i.odd? ? i : 33 - i }
}
inputs.each do |name, data|
  counts = %i[insertion merge_sort selection].map do |alg|
    c = Counter.new
    result = send(alg, data, c)
    raise "#{alg} failed" unless result == data.sort
    "#{alg}=#{c.count}"
  end
  puts "#{name.ljust(8)} #{counts.join(' ')}"
end
