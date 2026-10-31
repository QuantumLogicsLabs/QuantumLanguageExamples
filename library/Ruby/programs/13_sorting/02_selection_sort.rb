# Selection sort, tracing each pass.
def selection_sort(arr)
  a = arr.dup
  (0...a.size - 1).each do |i|
    min = (i...a.size).min_by { |j| a[j] }
    a[i], a[min] = a[min], a[i] if min != i
    puts "pass #{i + 1}: #{a.inspect}"
  end
  a
end

puts selection_sort([64, 25, 12, 22, 11]).inspect
puts selection_sort(%w[delta alpha charlie bravo]).inspect
