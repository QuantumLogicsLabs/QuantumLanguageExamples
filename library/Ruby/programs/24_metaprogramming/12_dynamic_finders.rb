# find_by_* methods generated on the fly.
class Repository
  def initialize(records) = @records = records

  def method_missing(name, *args)
    if (m = name.to_s.match(/\Afind_(all_)?by_(\w+)\z/))
      keys = m[2].split("_and_").map(&:to_sym)
      matcher = ->(r) { keys.zip(args).all? { |k, v| r[k] == v } }
      return m[1] ? @records.select(&matcher) : @records.find(&matcher)
    end
    super
  end

  def respond_to_missing?(name, priv = false) = name.to_s.start_with?("find_") || super
end

people = Repository.new([
  { name: "ana", city: "lima", age: 30 }, { name: "ben", city: "oslo", age: 25 },
  { name: "cy", city: "lima", age: 25 }, { name: "dee", city: "rome", age: 30 }
])
puts people.find_by_name("ben").inspect
puts people.find_all_by_city("lima").map { |r| r[:name] }.inspect
puts people.find_by_city_and_age("lima", 25).inspect
puts people.find_all_by_age(30).size
puts people.find_by_name("zed").inspect
puts people.respond_to?(:find_by_anything)
begin
  people.delete_everything
rescue NoMethodError
  puts "unknown method still raises"
end
