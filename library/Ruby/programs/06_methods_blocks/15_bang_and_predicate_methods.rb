# Conventions: ? for predicates, ! for dangerous versions.
class Playlist
  attr_reader :songs

  def initialize(*songs) = @songs = songs
  def empty? = @songs.empty?
  def include?(song) = @songs.include?(song)
  def sorted = Playlist.new(*@songs.sort)

  def sort!
    @songs.sort!
    self
  end

  def to_s = @songs.join(" | ")
end

list = Playlist.new("Zebra", "Alpha", "Moon")
puts list.empty?
puts list.include?("Moon")
puts list.sorted
puts list
list.sort!
puts list

words = %w[b c a]
puts words.sort.inspect
puts words.inspect
words.sort!
puts words.inspect
name = "  ruby  "
puts name.strip.inspect
name.strip!
puts name.inspect
puts "abc".upcase!.inspect
puts "ABC".upcase!.inspect
