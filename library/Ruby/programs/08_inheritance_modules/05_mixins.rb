# Sharing behaviour through modules.
module Walkable
  def walk = "#{name} walks"
end

module Swimmable
  def swim = "#{name} swims"
end

module Flyable
  def fly = "#{name} flies"
end

class Creature
  attr_reader :name
  def initialize(name) = @name = name
  def abilities = (self.class.ancestors & [Walkable, Swimmable, Flyable]).map { |m| m.name.sub("able", "") }
end

class Duck < Creature
  include Walkable
  include Swimmable
  include Flyable
end

class Fish < Creature
  include Swimmable
end

class Penguin < Creature
  include Walkable
  include Swimmable
end

[Duck.new("Donald"), Fish.new("Nemo"), Penguin.new("Pingu")].each do |c|
  actions = %i[walk swim fly].select { |a| c.respond_to?(a) }.map { |a| c.public_send(a) }
  puts actions.join(", ")
  puts "  #{c.class}: #{c.abilities.sort.join(' ')}"
end
puts Duck.include?(Flyable)
puts Penguin.ancestors.take(4).inspect
