# Identity, equality, dup and clone.
class Document
  attr_accessor :title, :tags

  def initialize(title, tags)
    @title = title
    @tags = tags
  end

  def initialize_copy(source)
    super
    @tags = source.tags.dup
  end
end

original = Document.new("Report", ["draft"])
shallow = original
copy = original.dup
copy.title = "Report v2"
copy.tags << "reviewed"

puts original.title
puts original.tags.inspect
puts copy.tags.inspect
puts shallow.equal?(original)
puts copy.equal?(original)

frozen = "constant".freeze
puts frozen.dup.frozen?
puts frozen.clone.frozen?
puts frozen.clone(freeze: false).frozen?

numbers = [[1, 2], [3]]
shallow_copy = numbers.dup
shallow_copy[0] << 99
puts numbers.inspect
deep = Marshal.load(Marshal.dump(numbers))
deep[1] << 7
puts numbers.inspect
puts deep.inspect
