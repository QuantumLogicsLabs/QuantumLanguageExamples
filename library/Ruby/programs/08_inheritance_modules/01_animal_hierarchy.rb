# Inheritance, super and polymorphism.
class Animal
  attr_reader :name

  def initialize(name) = @name = name
  def speak = "..."
  def describe = "#{name} the #{self.class.name.downcase} says #{speak}"
  def legs = 4
end

class Dog < Animal
  def speak = "Woof"
end

class Cat < Animal
  def speak = "Meow"
end

class Bird < Animal
  def initialize(name, can_fly: true)
    super(name)
    @can_fly = can_fly
  end

  def speak = "Tweet"
  def legs = 2
  def describe = super + (@can_fly ? " and flies" : " but cannot fly")
end

zoo = [Dog.new("Rex"), Cat.new("Tom"), Bird.new("Kiwi", can_fly: false), Bird.new("Polly"), Animal.new("Thing")]
zoo.each { |a| puts a.describe }
puts "Total legs: #{zoo.sum(&:legs)}"
puts zoo.group_by(&:class).map { |k, v| "#{k}: #{v.size}" }.join(", ")
puts Bird.superclass, Bird.superclass.superclass
