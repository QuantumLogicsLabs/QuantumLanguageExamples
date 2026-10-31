# A custom collection that gains Enumerable by defining each.
class WordList
  include Enumerable

  def initialize(text) = @words = text.split
  def each(&block)
    @words.each(&block)
    self
  end
end

list = WordList.new("the quick brown fox jumps over the lazy dog")
puts list.count
puts list.sort.inspect
puts list.map(&:upcase).first(3).inspect
puts list.select { |w| w.length > 4 }.inspect
puts list.min_by(&:length)
puts list.max_by(&:length)
puts list.include?("fox")
puts list.sort_by { |w| [-w.length, w] }.first(3).inspect
puts list.each_slice(3).map { |s| s.join(" ") }.inspect
puts list.tally.select { |_, c| c > 1 }.inspect
puts list.each_with_index.map { |w, i| "#{i}:#{w[0]}" }.join(" ")
puts list.reduce { |a, b| a.length >= b.length ? a : b }
puts list.to_a.length
puts list.lazy.map(&:reverse).first(2).inspect
