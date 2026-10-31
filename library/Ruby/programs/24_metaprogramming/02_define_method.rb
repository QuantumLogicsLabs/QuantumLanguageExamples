# Generating methods with define_method.
class Settings
  FIELDS = { theme: "light", font_size: 12, autosave: true }.freeze

  FIELDS.each do |name, default|
    define_method(name) { instance_variable_get("@#{name}") || default }
    define_method("#{name}=") { |v| instance_variable_set("@#{name}", v) }
    define_method("#{name}?") { !!send(name) } if [true, false].include?(default)
    define_method("reset_#{name}") { instance_variable_set("@#{name}", nil) }
  end

  def to_h = FIELDS.keys.to_h { |k| [k, send(k)] }
end

s = Settings.new
puts s.to_h.inspect
s.theme = "dark"
s.font_size = 16
s.autosave = false
puts s.to_h.inspect
puts s.autosave?
s.reset_theme
puts s.theme
puts Settings.public_instance_methods(false).sort.inspect
