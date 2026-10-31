# A small hierarchy of application errors.
class AppError < StandardError; end

class ValidationError < AppError
  attr_reader :field

  def initialize(field, message = "is invalid")
    @field = field
    super("#{field} #{message}")
  end
end

class NotFoundError < AppError
  def initialize(id) = super("record #{id} not found")
end

USERS = { 1 => { name: "Ana", email: "ana@example.com" } }.freeze

def find_user(id) = USERS.fetch(id) { raise NotFoundError.new(id) }

def validate(user)
  raise ValidationError.new(:name, "can't be blank") if user[:name].to_s.empty?
  raise ValidationError.new(:email) unless user[:email].to_s.include?("@")
  user
end

[-> { find_user(1) }, -> { find_user(9) }, -> { validate(name: "", email: "x@y") },
 -> { validate(name: "Bo", email: "nope") }, -> { validate(name: "Cy", email: "c@d") }].each do |job|
  puts "ok: #{job.call.inspect}"
rescue ValidationError => e
  puts "validation failed on #{e.field}: #{e.message}"
rescue AppError => e
  puts "#{e.class}: #{e.message}"
end
puts ValidationError.ancestors.take(4).inspect
