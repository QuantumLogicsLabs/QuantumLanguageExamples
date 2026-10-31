# Accumulating validation errors functionally.
Valid = Data.define(:value)
Invalid = Data.define(:errors)

def validate(value, *rules)
  errors = rules.filter_map { |msg, check| msg unless check.(value) }
  errors.empty? ? Valid.new(value) : Invalid.new(errors)
end

def combine(fields)
  invalid = fields.select { |_, r| r.is_a?(Invalid) }
  return Valid.new(fields.transform_values(&:value)) if invalid.empty?
  Invalid.new(invalid.flat_map { |name, r| r.errors.map { |e| "#{name} #{e}" } })
end

def check_signup(form)
  combine(
    name: validate(form[:name], ["is blank", ->(v) { !v.to_s.strip.empty? }]),
    age: validate(form[:age], ["is not a number", ->(v) { v.is_a?(Integer) }], ["is under 18", ->(v) { v.to_i >= 18 }]),
    email: validate(form[:email], ["has no @", ->(v) { v.to_s.include?("@") }], ["is too long", ->(v) { v.to_s.size <= 20 }])
  )
end

[{ name: "Ana", age: 30, email: "ana@x.io" }, { name: " ", age: 12, email: "nope" },
 { name: "Bo", age: "x", email: "bo@a-very-long-domain.example" }].each do |f|
  r = check_signup(f)
  puts r.is_a?(Valid) ? "ok: #{r.value.inspect}" : "errors: #{r.errors.join('; ')}"
end
