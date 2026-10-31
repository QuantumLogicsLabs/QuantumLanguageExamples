# Collecting all validation errors instead of stopping at the first.
class Form
  attr_reader :errors

  RULES = {
    username: [->(v) { "is required" if v.to_s.strip.empty? },
               ->(v) { "must be 3-12 characters" unless (3..12).cover?(v.to_s.length) }],
    age: [->(v) { "must be a number" unless v.to_s.match?(/\A\d+\z/) },
          ->(v) { "must be at least 13" if v.to_s.match?(/\A\d+\z/) && v.to_i < 13 }],
    email: [->(v) { "is not an email" unless v.to_s.match?(/\A[^@\s]+@[^@\s]+\.\w+\z/) }]
  }.freeze

  def initialize(data)
    @data = data
    @errors = Hash.new { |h, k| h[k] = [] }
  end

  def valid?
    RULES.each do |field, checks|
      checks.each do |check|
        message = check.call(@data[field])
        @errors[field] << message if message
      end
    end
    @errors.empty?
  end
end

[{ username: "ruby_fan", age: "30", email: "fan@ruby.org" },
 { username: "", age: "abc", email: "nope" },
 { username: "averyveryverylongname", age: "9", email: "kid@site.com" }].each do |data|
  form = Form.new(data)
  if form.valid?
    puts "#{data[:username]}: valid"
  else
    puts "#{data[:username].inspect}: #{form.errors.map { |f, m| "#{f} #{m.join(', ')}" }.join('; ')}"
  end
end
