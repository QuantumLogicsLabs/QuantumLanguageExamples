# A dynamic proxy using method_missing and respond_to_missing?.
class Recorder
  def initialize(target)
    @target = target
    @calls = []
  end

  attr_reader :calls

  def method_missing(name, *args, &block)
    if @target.respond_to?(name)
      @calls << "#{name}(#{args.map(&:inspect).join(', ')})"
      @target.public_send(name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(name, include_private = false) = @target.respond_to?(name, include_private) || super
end

list = Recorder.new([3, 1, 2])
list.push(5)
puts list.sort.inspect
puts list.map { |x| x * 2 }.inspect
puts list.include?(9)
puts list.respond_to?(:push)
puts list.respond_to?(:fly)
puts list.calls.inspect
begin
  list.fly
rescue NoMethodError => e
  puts "NoMethodError for #{e.name}"
end
