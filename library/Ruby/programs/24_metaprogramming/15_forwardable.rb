# Delegation with Forwardable.
require "forwardable"

class Playlist
  extend Forwardable
  include Enumerable

  def_delegators :@songs, :size, :first, :last, :empty?, :<<
  def_delegator :@songs, :join, :to_text

  def initialize(name) = (@name, @songs = name, [])
  def each(&block) = @songs.each(&block)
end

class Queue2
  extend Forwardable
  def_delegator :@items, :push, :enqueue
  def_delegator :@items, :shift, :dequeue
  def_delegators :@items, :size, :first
  def initialize = @items = []
end

pl = Playlist.new("road trip")
pl << "Song A" << "Song B" << "Song C"
puts pl.size, pl.first, pl.last
puts pl.to_text(" / ")
puts pl.map(&:upcase).inspect
puts pl.sort.reverse.first
q = Queue2.new
q.enqueue(1)
q.enqueue(2)
puts q.dequeue, q.size
