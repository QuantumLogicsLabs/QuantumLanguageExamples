# An employee directory: a hash of structs with lookups.
Contact = Struct.new(:name, :team, :phone, :manager)

DIR = [
  Contact.new("ana", "core", "x101", nil),
  Contact.new("ben", "core", "x102", "ana"),
  Contact.new("cy", "web", "x201", "ana"),
  Contact.new("dee", "web", "x202", "cy"),
  Contact.new("eli", "web", "x203", "cy"),
  Contact.new("fay", "data", "x301", "ben")
].to_h { |c| [c.name, c] }

def chain(name)
  out = []
  while name
    out << name
    name = DIR[name].manager
  end
  out
end

def reports(name) = DIR.values.select { |c| c.manager == name }.map(&:name)

def all_reports(name) = reports(name).flat_map { |r| [r] + all_reports(r) }

puts chain("eli").join(" -> ")
puts chain("fay").join(" -> ")
puts "ana manages #{reports('ana').inspect}"
puts "everyone under ana: #{all_reports('ana').sort.inspect}"
puts DIR.values.group_by(&:team).transform_values { |cs| cs.map(&:phone) }.inspect
