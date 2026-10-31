# Word ladder: shortest chain changing one letter at a time.
WORDS = %w[cold cord card ward warm wore core corn worm word wood good gold bold bolt colt cola].freeze

def neighbors(word, dict)
  dict.select { |w| w.length == word.length && w.chars.zip(word.chars).count { |a, b| a != b } == 1 }
end

def ladder(from, to)
  prev = { from => nil }
  queue = [from]
  until queue.empty?
    w = queue.shift
    return build(prev, to) if w == to
    neighbors(w, WORDS).each do |n|
      next if prev.key?(n)
      prev[n] = w
      queue << n
    end
  end
  nil
end

def build(prev, to)
  path = [to]
  path.unshift(prev[path.first]) while prev[path.first]
  path
end

[%w[cold warm], %w[gold wood], %w[bolt corn], %w[cola word]].each do |a, b|
  l = ladder(a, b)
  puts "#{a} -> #{b}: #{l ? l.join(' > ') : 'impossible'}"
end
