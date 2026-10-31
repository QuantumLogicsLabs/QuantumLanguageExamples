# Including Comparable for ordering by a key.
class Card
  include Comparable
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[clubs diamonds hearts spades].freeze

  attr_reader :rank, :suit

  def initialize(rank, suit) = (@rank, @suit = rank, suit)
  def value = RANKS.index(rank)
  def <=>(other) = [value, SUITS.index(suit)] <=> [other.value, SUITS.index(other.suit)]
  def to_s = "#{rank}#{suit[0].upcase}"
end

hand = [Card.new("Q", "hearts"), Card.new("3", "spades"), Card.new("A", "clubs"),
        Card.new("Q", "clubs"), Card.new("10", "diamonds")]
puts hand.sort.join(" ")
puts hand.max
puts hand.min
puts Card.new("K", "hearts") > Card.new("Q", "spades")
puts Card.new("7", "clubs").between?(Card.new("5", "hearts"), Card.new("9", "hearts"))
puts Card.new("2", "spades").clamp(Card.new("4", "clubs"), Card.new("8", "clubs"))
puts hand.sort.reverse.first(2).join(" & ")
