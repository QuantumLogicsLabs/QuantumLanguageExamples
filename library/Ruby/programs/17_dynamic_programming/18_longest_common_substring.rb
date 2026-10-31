# Longest common substring by dynamic programming.
def longest_common_substring(a, b)
  best_len = 0
  best_end = 0
  prev = Array.new(b.size + 1, 0)
  a.each_char.with_index(1) do |ca, i|
    cur = [0]
    b.each_char.with_index(1) do |cb, j|
      cur << (ca == cb ? prev[j - 1] + 1 : 0)
      if cur[j] > best_len
        best_len = cur[j]
        best_end = i
      end
    end
    prev = cur
  end
  a[best_end - best_len, best_len]
end

[%w[ABABC BABCA], %w[GeeksforGeeks GeeksQuiz], %w[photograph tomography], %w[abc xyz], %w[xabxac abcabxabcd]].each do |a, b|
  puts "#{a} & #{b}: #{longest_common_substring(a, b).inspect}"
end
