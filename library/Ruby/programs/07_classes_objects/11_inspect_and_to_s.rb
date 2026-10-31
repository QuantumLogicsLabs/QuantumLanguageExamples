# Custom string representations.
class Book
  attr_reader :title, :author, :year

  def initialize(title, author, year)
    @title, @author, @year = title, author, year
  end

  def to_s = "#{title} by #{author}"
  def inspect = "#<Book #{title.inspect} (#{year})>"
end

books = [Book.new("Dune", "Frank Herbert", 1965), Book.new("Emma", "Jane Austen", 1815)]
books.each { |b| puts b }
puts books.inspect
p books.first
puts "Reading: #{books.last}"
puts books.map(&:to_s).join("; ")
puts [1, "two", :three, nil, 4.0].inspect
puts [1, "two", :three, nil, 4.0].to_s
puts({ a: [1, { b: "c" }] }.to_s)
