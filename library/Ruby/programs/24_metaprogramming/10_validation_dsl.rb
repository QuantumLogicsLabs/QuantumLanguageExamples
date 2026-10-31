# A validates DSL in the style of web frameworks.
module Validations
  def self.included(base) = base.extend(ClassMethods)

  module ClassMethods
    def validations = @validations ||= []
    def validates(attr, **rules) = validations << [attr, rules]
  end

  def errors
    self.class.validations.flat_map do |attr, rules|
      value = public_send(attr)
      rules.filter_map do |rule, arg|
        case rule
        when :presence then "#{attr} can't be blank" if arg && value.to_s.strip.empty?
        when :length then "#{attr} length must be in #{arg}" unless arg.cover?(value.to_s.length)
        when :format then "#{attr} is invalid" unless value.to_s.match?(arg)
        when :inclusion then "#{attr} must be one of #{arg.join('/')}" unless arg.include?(value)
        end
      end
    end
  end

  def valid? = errors.empty?
end

class Signup
  include Validations
  attr_accessor :name, :email, :plan

  validates :name, presence: true, length: 2..20
  validates :email, presence: true, format: /\A[^@\s]+@[^@\s]+\z/
  validates :plan, inclusion: %w[free pro]

  def initialize(name, email, plan) = (@name, @email, @plan = name, email, plan)
end

[Signup.new("Ana", "ana@x.org", "pro"), Signup.new("", "nope", "gold"), Signup.new("B", "b@c.d", "free")].each do |s|
  puts s.valid? ? "#{s.name}: valid" : "#{s.name.inspect}: #{s.errors.join('; ')}"
end
