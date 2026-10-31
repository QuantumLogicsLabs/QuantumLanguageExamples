# Creating classes at runtime with Class.new.
def make_record(*fields)
  Class.new do
    attr_reader(*fields)
    define_method(:initialize) { |*values| fields.zip(values).each { |f, v| instance_variable_set("@#{f}", v) } }
    define_method(:to_s) { "#<#{self.class.name || 'anonymous'} " + fields.map { |f| "#{f}=#{send(f).inspect}" }.join(", ") + ">" }
    define_method(:==) { |o| o.class == self.class && fields.all? { |f| send(f) == o.send(f) } }
  end
end

Point = make_record(:x, :y)
Person = make_record(:name, :age, :email)
puts Point.new(1, 2)
puts Person.new("Ana", 30, "a@x.org")
puts Point.new(1, 2) == Point.new(1, 2)
temp = make_record(:value)
puts temp.new(42)
puts temp.name.inspect

Base = Class.new { def hello = "hello from #{self.class}" }
Child = Class.new(Base) { def hello = super + " (child)" }
puts Child.new.hello
puts Child.superclass
