# Freezing objects and the errors it causes.
CONFIG = { env: "prod", hosts: ["a", "b"] }.freeze

begin
  CONFIG[:env] = "dev"
rescue FrozenError => e
  puts "FrozenError: #{e.message[0, 30]}"
end

CONFIG[:hosts] << "c"
puts CONFIG[:hosts].inspect

def deep_freeze(obj)
  case obj
  when Hash then obj.each_value { |v| deep_freeze(v) }
  when Array then obj.each { |v| deep_freeze(v) }
  end
  obj.freeze
end

settings = deep_freeze({ list: [1, 2], name: +"x" })
[-> { settings[:list] << 3 }, -> { settings[:name] << "y" }, -> { settings.delete(:list) }].each do |job|
  job.call
  puts "changed"
rescue FrozenError
  puts "blocked"
end
puts settings.frozen?, settings[:list].frozen?
copy = settings.dup
puts copy.frozen?
puts :sym.frozen?, 42.frozen?, nil.frozen?
