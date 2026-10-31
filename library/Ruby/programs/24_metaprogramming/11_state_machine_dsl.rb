# A small state machine DSL.
module StateMachine
  def self.included(base) = base.extend(ClassMethods)

  module ClassMethods
    def states(*names) = @states = names
    def initial_state = @states.first
    def transitions = @transitions ||= {}

    def event(name, from:, to:)
      Array(from).each { |f| transitions[[name, f]] = to }
      define_method("#{name}!") do
        target = self.class.transitions[[name, state]]
        raise ArgumentError, "cannot #{name} from #{state}" unless target
        (@history ||= []) << "#{state} -#{name}-> #{target}"
        @state = target
        self
      end
      define_method("can_#{name}?") { self.class.transitions.key?([name, state]) }
    end
  end

  def state = @state ||= self.class.initial_state
  def history = @history || []
end

class Order
  include StateMachine
  states :pending, :paid, :shipped, :delivered, :cancelled
  event :pay, from: :pending, to: :paid
  event :ship, from: :paid, to: :shipped
  event :deliver, from: :shipped, to: :delivered
  event :cancel, from: %i[pending paid], to: :cancelled
end

o = Order.new
puts o.state
o.pay!.ship!
puts o.can_cancel?
begin
  o.cancel!
rescue ArgumentError => e
  puts e.message
end
o.deliver!
puts o.history
o2 = Order.new.cancel!
puts o2.state, o2.can_pay?
