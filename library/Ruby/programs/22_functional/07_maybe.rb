# An Option type to avoid nil checks.
class Option
  def self.of(v) = v.nil? ? NONE : Some.new(v)
end

class Some < Option
  attr_reader :value
  def initialize(v) = @value = v
  def map = Option.of(yield(value))
  def flat_map = yield(value)
  def or_else(_) = value
  def to_s = "Some(#{value.inspect})"
end

class NoneClass < Option
  def map = self
  def flat_map = self
  def or_else(default) = default
  def to_s = "None"
end
NONE = NoneClass.new

USERS = { 1 => { name: "Ana", address: { city: "Lima", zip: "15001" } }, 2 => { name: "Ben" }, 3 => { name: "Cy", address: { city: "Oslo" } } }.freeze

def find_user(id) = Option.of(USERS[id])
def address(user) = Option.of(user[:address])
def zip(addr) = Option.of(addr[:zip])

(1..4).each do |id|
  result = find_user(id).flat_map { |u| address(u) }.flat_map { |a| zip(a) }.map(&:to_i)
  puts "user #{id}: #{result} -> #{result.or_else('no zip')}"
end
puts find_user(3).map { |u| u[:name].upcase }
