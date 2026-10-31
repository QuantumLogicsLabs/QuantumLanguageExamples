# Generating comparison helpers from a single key.
module ComparableBy
  def compare_by(*keys)
    include Comparable
    define_method(:sort_key) { keys.map { |k| public_send(k) } }
    define_method(:<=>) { |other| sort_key <=> other.sort_key }
    keys.each do |k|
      define_singleton_method("by_#{k}") { |list| list.sort_by { |x| x.public_send(k) } }
    end
  end
end

class Runner
  extend ComparableBy
  attr_reader :name, :time, :age

  def initialize(name, time, age) = (@name, @time, @age = name, time, age)
  compare_by :time, :age
  def to_s = "#{name}(#{time}s, #{age})"
end

runners = [Runner.new("ana", 61.2, 30), Runner.new("ben", 59.8, 41), Runner.new("cy", 61.2, 25), Runner.new("dee", 63.0, 35)]
puts runners.sort.join(" ")
puts runners.min
puts runners[0] > runners[2]
puts Runner.by_age(runners).join(" ")
puts Runner.by_name(runners).join(" ") rescue puts "no by_name: name is not a sort key"
