# A ticket queue at a service desk.
class ServiceDesk
  Customer = Struct.new(:name, :arrival, :duration)

  def initialize(clerks)
    @free_at = Array.new(clerks, 0)
    @log = []
  end

  def serve(customers)
    customers.sort_by(&:arrival).each do |c|
      clerk = @free_at.each_with_index.min_by { |t, i| [t, i] }.last
      start = [@free_at[clerk], c.arrival].max
      @free_at[clerk] = start + c.duration
      @log << [c.name, clerk + 1, start, start - c.arrival]
    end
    self
  end

  def report
    @log.each { |name, clerk, start, wait| puts "#{name.ljust(5)} clerk #{clerk} starts at #{start.to_s.rjust(2)} (waited #{wait})" }
    puts "Average wait: #{(@log.sum(&:last).to_f / @log.size).round(2)}"
  end
end

people = [["Ana", 0, 5], ["Ben", 1, 3], ["Cy", 2, 8], ["Dee", 3, 2], ["Eli", 4, 4], ["Fay", 10, 1]]
customers = people.map { |n, a, d| ServiceDesk::Customer.new(n, a, d) }
ServiceDesk.new(2).serve(customers).report
