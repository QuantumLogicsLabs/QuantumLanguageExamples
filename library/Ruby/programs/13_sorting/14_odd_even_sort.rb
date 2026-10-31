# Odd-even transposition sort.
def odd_even_sort(arr)
  a = arr.dup
  phase = 0
  sorted = false
  until sorted
    sorted = true
    [1, 0].each do |start|
      (start...a.size - 1).step(2) do |i|
        next unless a[i] > a[i + 1]
        a[i], a[i + 1] = a[i + 1], a[i]
        sorted = false
      end
    end
    phase += 1
  end
  [a, phase]
end

out, phases = odd_even_sort([9, 7, 5, 3, 1, 2, 4, 6, 8, 0])
puts "#{out.inspect} after #{phases} rounds"
puts odd_even_sort([3, 2, 1]).inspect
