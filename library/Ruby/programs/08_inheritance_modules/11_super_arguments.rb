# super with implicit, explicit and empty arguments.
class Logger
  def log(message, level = :info) = "#{level.upcase}: #{message}"
end

class TimestampLogger < Logger
  def log(message, level = :info)
    "[t=42] " + super
  end
end

class ShoutLogger < Logger
  def log(message, level = :warn)
    super(message.upcase, level)
  end
end

class FixedLogger < Logger
  def log(*)
    super("fixed message")
  end
end

class Parent
  def initialize(*args) = @args = args
  def args = @args
end

class EmptySuper < Parent
  def initialize(a, b)
    super()
  end
end

class ImplicitSuper < Parent
  def initialize(a, b)
    super
  end
end

puts TimestampLogger.new.log("started")
puts TimestampLogger.new.log("disk low", :error)
puts ShoutLogger.new.log("careful")
puts FixedLogger.new.log("ignored", :debug)
puts EmptySuper.new(1, 2).args.inspect
puts ImplicitSuper.new(1, 2).args.inspect
