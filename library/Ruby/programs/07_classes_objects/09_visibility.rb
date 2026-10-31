# Public, private and protected methods.
class Employee
  attr_reader :name

  def initialize(name, salary)
    @name = name
    @salary = salary
  end

  def earns_more_than?(other) = salary > other.salary
  def summary = "#{name} (#{band})"

  protected

  def salary = @salary

  private

  def band
    case salary
    when 0...40_000 then "junior"
    when 40_000...80_000 then "mid"
    else "senior"
    end
  end
end

ana = Employee.new("Ana", 85_000)
ben = Employee.new("Ben", 52_000)
puts ana.summary
puts ben.summary
puts ana.earns_more_than?(ben)
[:salary, :band].each do |m|
  ana.public_send(m)
rescue NoMethodError => e
  puts "#{m}: #{e.message[/private|protected/]} method"
end
puts ana.send(:band)
puts Employee.private_instance_methods(false).inspect
puts Employee.protected_instance_methods.inspect
