# Subsets, supersets and set algebra on skills.
skills = {
  "ana" => Set["ruby", "sql", "git", "docker"],
  "ben" => Set["ruby", "git"],
  "cy" => Set["python", "sql", "git"],
  "dee" => Set["ruby", "sql", "git", "docker", "k8s"]
}
required = Set["ruby", "git", "sql"]

skills.each do |name, s|
  missing = required - s
  puts "#{name}: #{missing.empty? ? 'qualified' : "missing #{missing.to_a.sort.join(', ')}"}"
end
pairs = skills.keys.combination(2).select { |a, b| skills[a] < skills[b] || skills[b] < skills[a] }
puts "Strict subset pairs: #{pairs.inspect}"
everyone = skills.values.reduce(:&)
puts "Everyone knows: #{everyone.to_a.inspect}"
anyone = skills.values.reduce(:|)
puts "Someone knows: #{anyone.to_a.sort.inspect}"
unique = skills.to_h { |n, s| [n, (s - skills.reject { |k, _| k == n }.values.reduce(:|)).to_a] }
puts "Unique skills: #{unique.reject { |_, v| v.empty? }.inspect}"
