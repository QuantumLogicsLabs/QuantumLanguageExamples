# Ractor-based parallel computation (Ruby 3.0+). Unlike Threads,
# Ractors run without a shared GIL between them, giving true
# parallelism at the cost of restricted object sharing.
def parallel_sum(array, num_ractors = 4)
  chunk_size = (array.size.to_f / num_ractors).ceil
  chunks = array.each_slice(chunk_size).to_a

  ractors = chunks.map do |chunk|
    Ractor.new(chunk) { |data| data.sum }
  end

  ractors.sum(&:take)
end

if __FILE__ == $0
  if defined?(Ractor)
    data = (1..1_000_000).to_a
    result = parallel_sum(data)
    puts "Parallel sum of 1..1,000,000 = #{result}"
    puts "Expected: #{data.sum}"
  else
    puts "Ractor is not available in this Ruby version (requires Ruby 3.0+)."
  end
end
