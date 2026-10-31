# Stable versus unstable sorts on equal keys.
Card = Struct.new(:rank, :suit) do
  def to_s = "#{rank}#{suit}"
end

def insertion_sort_by(a, &key)
  a = a.dup
  (1...a.size).each do |i|
    x = a[i]
    j = i - 1
    while j >= 0 && key.call(a[j]) > key.call(x)
      a[j + 1] = a[j]
      j -= 1
    end
    a[j + 1] = x
  end
  a
end

def selection_sort_by(a, &key)
  a = a.dup
  (0...a.size).each do |i|
    m = (i...a.size).min_by { |j| key.call(a[j]) }
    a[i], a[m] = a[m], a[i]
  end
  a
end

hand = [Card.new(5, "H"), Card.new(3, "S"), Card.new(5, "S"), Card.new(2, "D"), Card.new(3, "H"), Card.new(5, "D")]
puts "input:     #{hand.join(' ')}"
puts "insertion: #{insertion_sort_by(hand, &:rank).join(' ')}"
puts "selection: #{selection_sort_by(hand, &:rank).join(' ')}"
puts "sort_by+i: #{hand.each_with_index.sort_by { |c, i| [c.rank, i] }.map(&:first).join(' ')}"
