# Books, members and loans.
class Book
  attr_reader :isbn, :title
  attr_accessor :borrower

  def initialize(isbn, title) = (@isbn, @title = isbn, title)
  def available? = borrower.nil?
end

class Member
  attr_reader :name, :books
  LIMIT = 2

  def initialize(name) = (@name, @books = name, [])
  def can_borrow? = books.size < LIMIT
end

class Library
  def initialize = @catalog = {}
  def add(book) = @catalog[book.isbn] = book

  def lend(isbn, member)
    book = @catalog[isbn]
    return "#{member.name}: no such book #{isbn}" unless book
    return "#{member.name}: '#{book.title}' is out" unless book.available?
    return "#{member.name}: limit reached" unless member.can_borrow?
    book.borrower = member
    member.books << book
    "#{member.name} borrowed '#{book.title}'"
  end

  def give_back(isbn)
    book = @catalog.fetch(isbn)
    book.borrower.books.delete(book)
    book.borrower = nil
    "'#{book.title}' returned"
  end

  def available = @catalog.values.select(&:available?).map(&:title)
end

lib = Library.new
[["111", "Dune"], ["222", "Emma"], ["333", "Ubik"]].each { |i, t| lib.add(Book.new(i, t)) }
ana, ben = Member.new("Ana"), Member.new("Ben")
puts lib.lend("111", ana)
puts lib.lend("111", ben)
puts lib.lend("222", ana)
puts lib.lend("333", ana)
puts lib.lend("999", ben)
puts lib.give_back("111")
puts lib.lend("111", ben)
puts "Available: #{lib.available.inspect}"
puts "Ana has: #{ana.books.map(&:title).inspect}"
